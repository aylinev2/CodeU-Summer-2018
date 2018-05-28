<!DOCTYPE html>
<html>
<head>
  <title>Admin</title>
  <link rel="stylesheet" href="/css/main.css">
</head>
<body>

  <%@ include file="navbar.jsp" %>

  <div id="container">

    <% if(username.equals("adminama")){ %>
      <h1>This is the admin page </h1>
    <% } else{ %>
      <ul>
        <li><a href="/login">Login</a> with an admin account in order to see this site.</li>
      </ul>
    <% } %>
  </div>

</body>
</html>