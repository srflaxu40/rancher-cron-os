FROM ubuntu:latest
MAINTAINER knepperjm@gmail.com

RUN mkdir -p /opt/run_scripts /artifacts && \
    chmod 755 /opt/run_scripts

COPY scripts/ /artifacts/

VOLUME /opt/run_scripts

RUN chmod -R 755 /artifacts

