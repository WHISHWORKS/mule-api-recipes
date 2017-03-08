<%@ page language="java"%>
<%@page import="java.io.*" %>
<%@page import="java.net.*" %>
<%
    String accessToken = request.getParameter("access_token");
%>
<head>
<title>OAuth Consumer</title>
</head>
<body link="#FFFFFF" vlink="#FFFFFF" alink="#FFFFFF" bgcolor="#000055"
 text="#FFFFFF">
 <center>
  <h3>OAuth Consumer Client</h3>
 </center>
 
 <p id="demo"></p>
 <p>
  <a href="index.jsp">Logout</a>
 </p>


 
<%
   String recv = "";
   String recvbuff = "";
   URL jsonpage = new URL("http://localhost:8081/resources?access_token=" + accessToken);
   URLConnection urlcon = jsonpage.openConnection();
   BufferedReader buffread = new BufferedReader(new InputStreamReader(urlcon.getInputStream()));

   while ((recv = buffread.readLine()) != null)
    recvbuff += recv;
   buffread.close();
	
   
%>
 <li><%= recvbuff %></li>

</body>
</html>
