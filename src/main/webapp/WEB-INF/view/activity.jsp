<%@ page import= "java.util.List" %>
<%@ page import= "codeu.model.data.Conversation" %>
<%@ page import= "codeu.model.data.User" %>
<%@ page import= "codeu.model.store.persistence.PersistentDataStore" %>
<%@ page import= "com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import= "com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import= "java.lang.Object" %>
<%@ page import= "java.time.format.DateTimeFormatter" %>
<%@ page import= "java.util.Date" %>
<%@ page import= "java.time.LocalDateTime" %>
<%@ page import= "java.time.ZoneId" %>
<%@ page import= "java.time.Instant" %>
<%@ page import= "java.time.format.FormatStyle" %>
<%@ page import= "java.util.Locale" %>

<!DOCTYPE html>
<html>
<head>
  <title>Activity</title>
  <link rel="stylesheet" href="/css/main.css">
</head>
<body>
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
  </nav>

  <div id="container">

      <h1>Site Activity</h1>
      <strong> Conversations: </strong>
      <%
      List<Conversation> conversations =
        (List<Conversation>) request.getAttribute("conversations");
      List<User> users = (List<User>) request.getAttribute("users");
      if(conversations == null || conversations.isEmpty()){
      %>
        <p>Aww nothing so far!</p>
      <%
      }
      else{
      %>
        <ul class="mdl-list">
      <%
        for(Conversation conversation : conversations){
      %>
         <li> 
          <% DateTimeFormatter formatter = DateTimeFormatter.ofLocalizedDateTime( FormatStyle.SHORT ).withLocale( Locale.US ).withZone( ZoneId.systemDefault() );
          Instant instant = conversation.getCreationTime();
          String output = formatter.format( instant ); %>
          <a> <%= conversation.getTitle() %> created at 
          <strong><%= output %></strong> </a>
        </li>
      <%
        }
      %>
        </ul>
      <%
      }
      %>
      <hr/>
      <strong> Users: </strong>
      <ul class="mdl-list">
      <%
        for(User user : users){
      %>
        <li> 
         <% DateTimeFormatter formatter = DateTimeFormatter.ofLocalizedDateTime( FormatStyle.SHORT ).withLocale( Locale.US ).withZone( ZoneId.systemDefault() );
          Instant instant = user.getCreationTime();
          String output = formatter.format( instant ); %>
          <a> <%= user.getName() %> joined at 
          <strong> <%= output %> </strong></a>
        </li>
      <%
        }
      %>
      </ul>
       <hr/>

    </div>
  </div>
</body>
</html>