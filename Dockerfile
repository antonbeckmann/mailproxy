FROM ubuntu:18.04
RUN apt-get update && apt-get install -y ssmtp
ADD ./ssmtp.conf /etc/ssmtp/ssmtp.conf
