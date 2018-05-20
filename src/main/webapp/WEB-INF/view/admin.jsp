<!DOCTYPE html>
<html>
<head>
  <title>Admin</title>
  <link rel="stylesheet" href="/css/main.css">
</head>
<body>

  <nav>
    <a id="navTitle" href="/">CodeU Chat App</a>
    <% String username = (String) request.getSession().getAttribute("user");%>
    <% if(username != null){ %>
    <a href="/conversations">Conversations</a>
      <a>Hello <%=username%>!</a>
    <% } else{ %>
      <a href="/login">Login</a>
    <% } %>
    <a href="/about.jsp">About</a>
    <% if(username.equals("adminama")){ %>
    <a href="/admin.jsp">Admin</a>
    <% } %>
  </nav>

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