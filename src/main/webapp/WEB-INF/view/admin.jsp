
<%@ page import="codeu.model.data.User" %>
<%@ page import="codeu.model.data.Conversation" %>
<%@ page import="codeu.model.data.Message" %>
<%@ page import="codeu.model.store.basic.UserStore" %>
<%@ page import="codeu.model.store.basic.ConversationStore" %>
<%@ page import="codeu.model.store.basic.MessageStore"%>

<%
//Gets Instances of the different Datastores.
UserStore userStore = UserStore.getInstance();
ConversationStore conversationStore = ConversationStore.getInstance();
MessageStore messageStore = MessageStore.getInstance();

//Recieves the size the different Datastores.
Integer totalUsers = userStore.totalNumberOfUsers();
Integer totalConversations = conversationStore.totalNumberOfConversations();
Integer totalMessages = messageStore.totalNumberOfMessages();
%>

<!DOCTYPE html>
<html>
<head>
  <title>Admin</title>
  <link rel="stylesheet" href="/css/main.css">
</head>
<body>

  <%@ include file="navbar.jsp" %>


  <div id="container">
      <h1>Admin Page</h1>
      <h2>Site Statistics</h2>
      <ul>
        <li><h3>Users: <%= totalUsers %></h3></li>
        <li><h3>Conversations: <%= totalConversations %></h3></li>
        <li><h3>Messages: <%= totalMessages %></h3></li>
      </ul>
  </div>

</body>
</html>