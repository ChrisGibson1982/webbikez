FROM centos:latest as intermediate
RUN yum -y install git

RUN git clone https://github.com/ChrisGibson1982/webbikez-web.git

FROM nginx:latest

ENV WEBBIKEZ_VERSION=2.0.0
ENV SUMMARY="WebBikez test Nginx website running on CentOS 7" \
    DESCRIPTION="This is a website for a fictional bike manufacturer running on Nginx on  CentOs7.\
    The Container should run as a user so can be used on  OpenShift"

LABEL summary="$SUMMARY" \
      description="$DESCRIPTION" \
      name="cgfootman/webbikeztest" \
      version="$WEBBIKEZ_VERSION" \
      maintainer="cgfootman@hotmail.com" 

COPY --from=intermediate /webbikez-web /usr/share/nginx/html

RUN ls /

CMD ["nginx", "-g", "daemon off;"]