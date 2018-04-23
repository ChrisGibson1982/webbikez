#
#  docker build -t cgfootman/webbikez -f Dockerfile .
#  docker run -d -p 8080:80 --name webbikez cgfootman/webbikez:latest 
#  docker push cgfootman/webbikez


FROM centos:latest
LABEL maintainer="cgfootman@hotmail.com" 

EXPOSE 80

RUN yum -y install epel-release && \
    yum -y install nginx git logrotate && \
    yum clean all 

ADD nginx/global.conf /etc/nginx/conf.d/ 
ADD nginx/nginx.conf /etc/nginx/nginx.conf 

ADD Site/  /var/www/html/website

RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

CMD ["nginx", "-g", "daemon off;"]
