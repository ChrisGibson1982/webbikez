#
#  docker build -t cgfootman/webbikez:1.0.9 -t cgfootman/webbikez:latest  -f Dockerfile .
#  docker run -d -p 8080:80 --name webbikez cgfootman/webbikez
#  docker push cgfootman/webbikez


FROM centos:latest
LABEL maintainer="cgfootman@hotmail.com" 
LABEL version="1.1.0"

EXPOSE 80

RUN yum -y install epel-release && \
    yum -y install nginx git logrotate && \
    yum clean all && rm -rf /var/cache/yum 


COPY nginx/global.conf /etc/nginx/conf.d/ 
COPY nginx/nginx.conf /etc/nginx/nginx.conf 

RUN mkdir temp && \
    cd temp &&\
    git clone https://github.com/ChrisGibson1982/webbikez-web.git && \
    mv /webbikez-web/* /var/www/html/website

# COPY Site/  /var/www/html/website

RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

CMD ["nginx", "-g", "daemon off;"]
