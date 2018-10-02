#
#  docker build -t cgfootman/webbikez:1.0.9 -t cgfootman/webbikez:latest  -f Dockerfile .
#  docker run -d -p 8080:80 --name webbikez cgfootman/webbikez
#  docker push cgfootman/webbikez
FROM centos:latest as intermediate
RUN yum -y install git

RUN git clone https://github.com/ChrisGibson1982/webbikez-web.git


FROM centos:latest

EXPOSE 80

ENV WEBBIKEZ_VERSION=2.0.0
ENV SUMMARY="WebBikez test Nginx website running on CentOS 7" \
    DESCRIPTION="This is a website for a fictional bike manufacturer running on Nginx on  CentOs7.\
    The Container should run as a user so can be used on  OpenShift"

LABEL summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="Webbikez version $WEBBIKEZ_VERSION" \
      io.openshift.expose-services="80:http" \
      io.openshift.tags="nginx" \
      name="cgfootman/webbikeztest" \
      version="$WEBBIKEZ_VERSION" \
      maintainer="cgfootman@hotmail.com" 

ENV NGINX_CONFIGURATION_PATH=${APP_ROOT}/etc/nginx.d \
    NGINX_CONF_PATH=/etc/opt/rh/rh-nginx112/nginx/nginx.conf \
    NGINX_DEFAULT_CONF_PATH=${APP_ROOT}/etc/nginx.default.d \
    NGINX_CONTAINER_SCRIPTS_PATH=/usr/share/container-scripts/nginx \
    NGINX_APP_ROOT=${APP_ROOT}

RUN yum install -y yum-utils gettext hostname && \
    yum install -y centos-release-scl-rh && \
    INSTALL_PKGS="nss_wrapper bind-utils rh-nginx112 rh-nginx112-nginx" && \
    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all && \
    rm -rf /var/cache/yum

COPY --from=intermediate /webbikez-web /var/www/html/website

# RUN ln -sf /dev/stdout /var/log/nginx/access.log
# RUN ln -sf /dev/stderr /var/log/nginx/error.log

COPY ./root/ /

RUN cd ${APP_ROOT}/root

RUN pwd



RUN sed -i -f ${NGINX_APP_ROOT}/nginxconf.sed ${NGINX_CONF_PATH} && \
    chmod a+rwx ${NGINX_CONF_PATH} && \
    mkdir -p ${NGINX_APP_ROOT}/etc/nginx.d/ && \
    mkdir -p ${NGINX_APP_ROOT}/etc/nginx.default.d/ && \
    mkdir -p ${NGINX_APP_ROOT}/src/nginx-start/ && \
    mkdir -p ${NGINX_CONTAINER_SCRIPTS_PATH}/nginx-start && \
    mkdir -p /var/opt/rh/rh-nginx${NGINX_SHORT_VER}/log/nginx && \
    ln -sf /dev/stdout /var/opt/rh/rh-nginx${NGINX_SHORT_VER}/log/nginx/access.log && \
    ln -sf /dev/stderr /var/opt/rh/rh-nginx${NGINX_SHORT_VER}/log/nginx/error.log && \
    chmod -R a+rwx ${NGINX_APP_ROOT}/etc && \
    chmod -R a+rwx /var/opt/rh/rh-nginx${NGINX_SHORT_VER} && \
    chmod -R a+rwx ${NGINX_CONTAINER_SCRIPTS_PATH}/nginx-start && \
    chown -R 1001:0 ${NGINX_APP_ROOT} && \
    chown -R 1001:0 /var/opt/rh/rh-nginx${NGINX_SHORT_VER} && \
    chown -R 1001:0 ${NGINX_CONTAINER_SCRIPTS_PATH}/nginx-start && \
    rpm-file-permissions

USER 1001

ENV BASH_ENV=${NGINX_APP_ROOT}/etc/scl_enable \
    ENV=${NGINX_APP_ROOT}/etc/scl_enable \
    PROMPT_COMMAND=". ${NGINX_APP_ROOT}/etc/scl_enable"

CMD ["nginx", "-g", "daemon off;"]
