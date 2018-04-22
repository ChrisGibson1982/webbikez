
#  docker build -t cgfootman/webbikez:core -f servercore/Dockerfile .
#  docker run -d -p 80:80 --name webbikezcore cgfootman/webbikez:core
#  docker push cgfootman/webbikez:core

FROM microsoft/windowsservercore
MAINTAINER Chris Gibson <cgfootman@hotmail.com>
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ADD servercore/install/ServiceMonitor.exe /ServiceMonitor.exe


RUN powershell -Command Add-WindowsFeature Web-Server

RUN Remove-Website 'Default Web Site';

RUN mkdir C:\site

RUN powershell -NoProfile -Command \
    Import-module IISAdministration; \
    New-IISSite -Name "WebBikez" -PhysicalPath C:\site -BindingInformation "*:80:"

ADD Site/ /site

EXPOSE 80

ENTRYPOINT ["C:\\ServiceMonitor.exe", "w3svc"]



