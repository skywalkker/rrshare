FROM alpine:latest

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="skywalker"

ENV GLIBC_VERSION=2.31-r0 TZ=Asia/Shanghai

RUN \
 echo "**** install packages ****" && \
 apk add --no-cache \
	wget \
	libstdc++ && \
 wget "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk" && \
 wget "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk" && \
 wget "http://appdown.rrys.tv/rrshareweb_linux_2.20.tar.gz" &&\
 apk add --allow-untrusted glibc-${GLIBC_VERSION}.apk glibc-bin-${GLIBC_VERSION}.apk  && tar -xvf rrshareweb_linux_2.20.tar.gz  -C /opt/ && \
 apk del wget && rm -rf *.apk && rm -rf *.tar.gz 
 
 RUN chmod -R 777  /opt/*
# ports and volumes
EXPOSE 3001 
CMD ["/opt/data"]
