<nav>
    <a id="navTitle" href="/">CodeU Chat App</a>
    <a href="/conversations">Conversations</a>
    <% if(request.getSession().getAttribute("user") != null){ %>
      <a>Hello <%= request.getSession().getAttribute("user") %>!</a>
    <% } else{ %>
      <a href="/login">Login</a>
    <% } %>
    <a href="/about.jsp">About</a>
    <a href="/activity">Activity</a>
    <% String username = (String) request.getSession().getAttribute("user");
    if(username !=null && username.equals("adminama")){
    %>
     <a href="/admin">Admin</a> 
     <% } %>
</nav>