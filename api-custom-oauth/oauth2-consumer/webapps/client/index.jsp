<%@ page import="net.smartam.leeloo.client.request.*"%>
<%@ page import="net.smartam.leeloo.client.response.*"%>
<%@ page import="net.smartam.leeloo.common.message.types.GrantType"%>
<%@ page import="net.smartam.leeloo.client.*"%>
<%@ page import="org.mule.util.StringUtils"%>
<%@ page language="java"%>
<%
String code = request.getParameter("code");
String TOKEN_URL = "http://localhost:8081/oauthprovider/api/token";
String AUTHORIZE_URL = "http://localhost:8081/oauthprovider/api/authorize";
String CLIENT_ID = "12345";
String CLIENT_SECRET = "abc";
if (StringUtils.isNotBlank(code)) {
    OAuthClientRequest oAuthTokenRequest =
       OAuthClientRequest.tokenLocation(TOKEN_URL)
       .setGrantType(GrantType.AUTHORIZATION_CODE)
       .setCode(code)
       .setClientId(CLIENT_ID)
       .setClientSecret(CLIENT_SECRET)
       .setRedirectURI("http://localhost:8085/client/index.jsp")
       .buildBodyMessage();
  
    OAuthClient oAuthClient = new OAuthClient(new URLConnectionClient());
  
    OAuthAccessTokenResponse oAuthTokenResponse = oAuthClient.accessToken(oAuthTokenRequest);
    
    String accessToken = oAuthTokenResponse.getAccessToken();
    if (StringUtils.isNotBlank(accessToken)) {
        response.sendRedirect("home.jsp?access_token="+accessToken);
    }
}

%>
<head>
    <link rel="stylesheet" href="css/client.css" type="text/css">
    <title>OAuth Consumer</title>
</head>
<%
String authorizationRequestUrl =
  OAuthClientRequest
    .authorizationLocation(AUTHORIZE_URL)
    .setResponseType("code")
    .setClientId(CLIENT_ID)
    .setRedirectURI("http://localhost:8085/client/index.jsp")
    .setScope("READ_RESOURCE")
    .buildQueryMessage()
    .getLocationUri();
%>

<body>

<div class="title">
    <h3>Welcome to the OAuth Consumer Client</h3>
</div>
<hr />

<%
    String error = request.getParameter("error");
    String errorDescription = StringUtils.trimToEmpty(request.getParameter("error_description"));

    if (StringUtils.isNotBlank(error)) { %>
<h3>Login failed: <%= StringUtils.isNotBlank(errorDescription) ? errorDescription : error %></h3>
<% } %>


<form method="POST" name="login">
    <div class="content">
        <h2>Login</h2>
        <p><label for="username">Username:</label> <input type="text" id="username" /></p>
        <p><label for="password">Password:</label> <input type="password" id="password" /></p>
        <p class="submit"><button type="button" disabled="true">Login</button></p>
    </div>
    <div class="content">
        <h2>Or sign-in with</h2>
        <p class="signin"><a href="<%=authorizationRequestUrl%>"><b>Your Oauth Service Provider Account</p>
    </div>
</form>
<hr class="clear"/>
</body>
</html>