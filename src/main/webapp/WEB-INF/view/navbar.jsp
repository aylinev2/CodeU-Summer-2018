<nav>
    <a id="navTitle" href="/">CodeU Chat App</a>
    <% String username = (String) request.getSession().getAttribute("user");
        if(username != null){ %>
      <a href= "/profile/<%=username%>">Hello <%=username%>!</a>
     <% } else{ %>
      <a href="/login">Login</a>
    <% } %>
    <a href="/conversations">Conversations</a>
    <a href="/about.jsp">About</a>
    <a href="/activity">Activity</a>
    <% 
    if(username !=null && username.equals("adminama")){
    %>
     <a href="/admin">Admin</a> 
     <% } %>
</nav>