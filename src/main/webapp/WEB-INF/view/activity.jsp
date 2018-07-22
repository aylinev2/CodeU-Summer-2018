<%@ page import= "java.util.List" %>
<%@ page import= "codeu.model.data.Conversation" %>
<%@ page import= "codeu.model.store.basic.ConversationStore"%>
<%@ page import="codeu.model.store.basic.MessageStore"%>
<%@ page import="codeu.model.data.Message" %>
<%@ page import= "codeu.model.data.User" %>
<%@ page import= "codeu.model.store.basic.UserStore" %>
<%@ page import= "java.util.UUID" %>
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
<%@ page import= "java.util.HashMap" %>
<%@ page import= "java.util.Map" %>
<%@ page import= "com.vdurmont.emoji.EmojiParser" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Activity</title>
  <link rel="stylesheet" href="/css/main.css">
</head>
<body>

  <%@ include file="navbar.jsp" %>

  
  <div id="container">
      <% DateTimeFormatter formatter = DateTimeFormatter.ofLocalizedDateTime( FormatStyle.SHORT ).withLocale( Locale.US ).withZone( ZoneId.systemDefault() ); %>

      <h1>Site Activity</h1>
      <p> All that's going on: (Jump to- 
        <a id="ul-link" href="#1">Conversations</a>
        <a id="ul-link" href="#2">Users</a>
        <a id="ul-link" href="#3">Messages</a> ) </p>
    
      <section id="1">
      <strong> Conversations: </strong>
      <%
      List<Conversation> conversations =
        (List<Conversation>) request.getAttribute("conversations");
      List<Message> messages =
        (List<Message>) request.getAttribute("messages");
      List<User> users = 
        (List<User>) request.getAttribute("users");
      HashMap<UUID, String> idToName =
        (HashMap<UUID, String>) request.getAttribute("idToName");
      HashMap<UUID, String> idToTitle =
        (HashMap<UUID, String>) request.getAttribute("idToTitle");

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
          <% 
          String owner = (String) idToName.get(conversation.getOwnerId());
          Instant instant = conversation.getCreationTime();
          String output = formatter.format( instant ); %>
          <strong><%= output %>:</strong>
          <a id="link" href="/chat/<%= conversation.getTitle() %>">
        <strong><%= EmojiParser.parseToUnicode(conversation.getTitle()) %></strong></a> created by 
        <strong><a id="link" href="/profile/<%= owner%>">
        <%= owner %> </a> </strong>
        </li>
      <%
        }
      %>
        </ul>
      <%
      }
      %>
      <hr/>
      </section>
      <section id="2">
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
        for(User user: users){
      %>
        <li> 
         <% 
          Instant instant = user.getCreationTime();
          String output = formatter.format( instant ); %>
          <strong> <%= output %>: </strong>
          <strong> <a id="link" href="/profile/<%= user.getName()%>">
          <%= user.getName() %> </a> </strong> joined! 
        </li>
      <%
        }
      %>
      </ul>
      <%
      }
      %>
       <hr/>
      </section>
      <section id="3">
      <strong> Messages: </strong>
      <%
      if(messages == null || messages.isEmpty()){
      %>
        <p>Aww nothing so far!</p>
      <%
      }
      else{
      %>
        <ul class="mdl-list">
      <%
        for(Message message: messages){
      %>
        <li> 
         <% 
          String owner = (String) idToName.get(message.getAuthorId());
          String title = EmojiParser.parseToUnicode((String) idToTitle.get(message.getConversationId()));
          Instant instant = message.getCreationTime();
          String output = formatter.format( instant ); 
          if (message.getParentMessageId() == null) { %>
          <strong> <%= output %>: </strong>
          <strong> <a id="link" href="/profile/<%= owner%>"><%= owner %> </a> </strong> sent a message in
          <strong><a id="link" href="/chat/<%= title %>">
          <%= title %></a></strong>
          : "<%=message.getContent()%>"
          <% } 
          else { %>
          <strong> <%= output %>: </strong>
          <strong> <a id="link" href="/profile/<%= owner%>"><%= owner %> </a> </strong> replied to a message in
          <strong><a id="link" href="/chat/<%= title %>">
          <%= title %></a></strong>
          : "<%=message.getContent()%>"
          <% } %>
        </li>
      <%
        }
      %>
      </ul>
      <%
      }
      %>
    </section>

    
  </div>
</body>
</html>