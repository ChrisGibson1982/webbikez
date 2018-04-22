<html>
 <body>
 Server Information <br>
 ================== <br>
 Server Name = <%=Request.ServerVariables("SERVER_NAME")%> <br>
 Server Protocol = <%=Request.ServerVariables("SERVER_PROTOCOL")%> <br>
 Server IP = <%=Request.ServerVariables("LOCAL_ADDR")%> <br>
 Server Port = <%=Request.ServerVariables("SERVER_PORT")%> <br>
 IIS Version = <%=Request.ServerVariables("SERVER_SOFTWARE")%> <br>
<br>
Website Information <br>
------------------- <br>
Application Physical Path = <%=Request.ServerVariables("APPL_PHYSICAL_PATH")%> <br>
Application Translated Path = <%=Request.ServerVariables("PATH_TRANSLATED")%> <br>
<br>
</body>
</html>   