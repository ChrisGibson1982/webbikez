
#  docker build -t cgfootman/webbikez:nano -f nanoserver/Dockerfile .
#  docker run -d -p 80:80 --name webbikeznano cgfootman/webbikez:nano
#  docker push cgfootman/webbikez:nano

FROM microsoft/nanoserver

MAINTAINER Chris Gibson <cgfootman@hotmail.com>

ADD https://az880830.vo.msecnd.net/nanoserver-ga-2016/Microsoft-NanoServer-IIS-Package_base_10-0-14393-0.cab /install/Microsoft-NanoServer-IIS-Package_base_10-0-14393-0.cab
ADD https://az880830.vo.msecnd.net/nanoserver-ga-2016/Microsoft-NanoServer-IIS-Package_English_10-0-14393-0.cab /install/Microsoft-NanoServer-IIS-Package_English_10-0-14393-0.cab
ADD nanoserver/install/ServiceMonitor.exe /ServiceMonitor.exe

RUN dism.exe /online /add-package /packagepath:c:\install\Microsoft-NanoServer-IIS-Package_base_10-0-14393-0.cab & \
    dism.exe /online /add-package /packagepath:c:\install\Microsoft-NanoServer-IIS-Package_English_10-0-14393-0.cab & \
    dism.exe /online /add-package /packagepath:c:\install\Microsoft-NanoServer-IIS-Package_base_10-0-14393-0.cab & \
    rd /s /q c:\install

ADD Site/ /inetpub/wwwroot/

EXPOSE 80

ENTRYPOINT ["C:\\ServiceMonitor.exe", "w3svc"]
