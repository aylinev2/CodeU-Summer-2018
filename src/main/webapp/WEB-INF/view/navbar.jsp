<%@ page import= "codeu.model.store.basic.UserStore" %>

<nav>
    <a id="navTitle" href="/">CodeU Chat App</a>
    <% String username = (String) request.getSession().getAttribute("user");
        if(username != null){ %>
      <a href= "/profile/<%=username%>">Hello <%=username%>!</a>
      <a href="/logout">Logout</a>
     <% } else{ %>
      <a href="/login">Login</a>
    <% } %>
    <a href="/map">Map</a>
    <a href="/conversations">Conversations</a>
    <a href="/about.jsp">About</a>
    <a href="/activity">Activity</a>
    <% 
    if(username !=null && UserStore.getInstance().hasAdmin(username)){
    %>
     <a href="/admin">Admin</a> 
     <% } %>
</nav>