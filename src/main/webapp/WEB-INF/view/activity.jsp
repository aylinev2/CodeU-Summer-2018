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

  <%@ include file="navbar.jsp" %>

  <div id="container">
      <% DateTimeFormatter formatter = DateTimeFormatter.ofLocalizedDateTime( FormatStyle.SHORT ).withLocale( Locale.US ).withZone( ZoneId.systemDefault() ); %>

      <h1>Site Activity</h1>
      <p> All that's going on:</p>
      <strong> Conversations: </strong>
      <%
      List<Conversation> conversations =
        (List<Conversation>) request.getAttribute("conversations");
      List<User> users = 
        (List<User>) request.getAttribute("users");
      if(conversations == null || conversations.isEmpty()){
      %>
        <p>Aww nothing so far!</p>
      <%
      }
      else{
      %>
        <ul class="mdl-list">
      <%
        for(int i=conversations.size()-1; i>=0; i--){
      %>
         <li> 
          <% 
          Instant instant = conversations.get(i).getCreationTime();
          String output = formatter.format( instant ); %>
          <a href="/chat/<%= conversations.get(i).getTitle() %>">
        <%= conversations.get(i).getTitle() %></a> created at 
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
      <%
      if(users == null || users.isEmpty()){
      %>
        <p>Aww nothing so far!</p>
      <%
      }
      else{
      %>
        <ul class="mdl-list">
      <%
        for(int i=users.size()-1; i>=0; i--){
      %>
        <li> 
         <% 
          Instant instant = users.get(i).getCreationTime();
          String output = formatter.format( instant ); %>
          <a> <%= users.get(i).getName() %> joined at 
          <strong> <%= output %> </strong></a>
        </li>
      <%
        }
      %>
      </ul>
      <%
      }
      %>
       <hr/>

    </div>
  </div>
</body>
</html>