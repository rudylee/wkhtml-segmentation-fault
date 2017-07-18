FROM heroku/cedar:14

RUN apt-get update
RUN apt-get install -y libxext6
RUN apt-get install -y libxrender1
RUN apt-get install -y libfontconfig1
RUN apt-get install -y xz-utils

COPY . /app/
