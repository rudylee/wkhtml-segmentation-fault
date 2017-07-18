# The error

Our web app is hosted on Heroku and we are using `PDFkit` gem which is a wrapper for `wkhtmltopdf` for Rails.

We can't replicate the error on OSX or plain Ubuntu 14.04. That's why the docker image is using `heroku/cedar:14` as the base image.

```
root@53be92aa4231:/app# ./wkhtmltox/bin/wkhtmltopdf --dpi 1200 --page-size A4 --print-media-type --load-error-handling ignore --disable-smart-shrinking --margin-top 8mm --margin-bottom 25mm --margin-right 5mm --margin-left 5mm --zoom 1 --footer-html footer.html letter.html output.pdf
Loading pages (1/6)
Counting pages (2/6)
Resolving links (4/6)
Loading headers and footers (5/6)
Printing pages (6/6)
Segmentation fault===========================================] Page 5 of 4
root@53be92aa4231:/app#
```

# Version

- wkhtmltopdf: - `0.12.4 (with patched qt)`
- Operating System: `Heroku Cedar based on Ubuntu 14.04`

# How to Reproduce

1. Install Docker https://docs.docker.com/engine/installation/

2. Clone this repository

3. Build the docker image inside the repository folder

```
docker build . -t wkhtml-segmentation-fault:latest
```

4. Run the docker image

```
docker run -it wkhtml-segmentation-fault:latest /bin/bash
```

5. Inside the docker container, change to `/app` directory

```
cd /app
```

6. Extract `wkhtmltox-0.12.4_linux-generic-amd64.tar.xz`

```
tar xf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
```

7. Run `convert.sh` to run the conversion

```
./convert.sh
```

8. or you can run the command below inside the `app` directory

```
./wkhtmltox/bin/wkhtmltopdf --dpi 1200 --page-size A4 --print-media-type --load-error-handling ignore --disable-smart-shrinking --margin-top 8mm --margin-bottom 25mm --margin-right 5mm --margin-left 5mm --zoom 1 --footer-html footer.html letter.html output.pdf
```

# What I've found so far

- If you remove `--disable-smart-shrinking` the error won't occur
- If you remove `--footer-html` and `footer.html` the error won't occur
- I can't replicate the error on `Ubuntu 14.04`. Heroku probably added something to their image that causes the error.
