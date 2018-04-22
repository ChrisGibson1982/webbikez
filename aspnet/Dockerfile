
#  docker build -t cgfootman/webbikez:aspnet -f aspnet/Dockerfile .
#  docker run -d -p 8000:80 --name webbikezaspnet cgfootman/webbikez:aspnet
#  docker push cgfootman/webbikez:aspnet

FROM microsoft/aspnet

MAINTAINER Chris Gibson <cgfootman@hotmail.com>

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Ref container does not have expose, so have to use default port
EXPOSE 8000

ADD Site/ /inetpub/wwwroot/



