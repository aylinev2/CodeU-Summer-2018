<%--
  Copyright 2017 Google Inc.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--%>
<%@ page import="java.util.List" %>
<%@ page import="codeu.model.data.Conversation" %>
<%@ page import="codeu.model.data.Message" %>
<%@ page import="codeu.model.store.basic.UserStore" %>
<%@ page import="codeu.model.store.basic.MessageStore" %>
<%
Conversation conversation = (Conversation) request.getAttribute("conversation");
List<Message> messages = (List<Message>) request.getAttribute("messages");
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title><%= conversation.getTitle() %></title>
  <link rel="stylesheet" href="/css/main.css" type="text/css">

  <style>
    #chat {
      background-color: white;
      height: 500px;
      overflow-y: scroll
    }

    function toogleReply() {

    }
  </style>

  <script>
    // scroll the chat div to the bottom
    function scrollChat() {
      var chatDiv = document.getElementById('chat');
      chatDiv.scrollTop = chatDiv.scrollHeight;
    };
  </script>
</head>
<body onload="scrollChat()">

   <%@ include file="navbar.jsp" %>

  <div id="container">

    <h1><%= conversation.getTitle() %>
      <a href="" style="float: right">&#8635;</a></h1>

    <hr/>

    <div id="chat">
      <ul>
    <%
      for (Message message : messages) {
        String author = UserStore.getInstance()
        .getUser(message.getAuthorId()).getName();
    %>
      <li><strong><%= author %>:</strong> <%= message.getContent() %>
      <% 
      List<Message> replies = MessageStore.getInstance().getRepliesInMessage(message.getId());
      if( replies != null) {
        for(Message reply: replies) {
        String replyAuthor = UserStore.getInstance()
        .getUser(reply.getAuthorId()).getName();
    %>
      <p style ="padding-left:2em">
      <strong><%= replyAuthor %>:</strong> <%= reply.getContent()%> </p>
    <%
      }
    }
    %>
      </li>
    <%
     if (request.getSession().getAttribute("user") != null) { %> 
      <form action="/chat/<%= conversation.getTitle() %>" method="POST" id="replyForm">
        <input type="hidden" name="messageUUID" value="<%= message.getId().toString() %>" />
        <input type="text" name="reply">
        <button type="submit">Reply</button>
      </form>
      <% 
      }
    } %>
      </ul>
    </div>

    <hr/>

    <% if (request.getSession().getAttribute("user") != null) { %>
    <form action="/chat/<%= conversation.getTitle() %>" method="POST">
        <input type="text" name="message">
        <br/>
        <button type="submit">Send</button>
        <br>
        <p> Our chat app currently supports BBCode for text styling. <a href="/guide.jsp">Click here</a> to learn more about our text styling options.</p>
    </form> 
    <% } else { %>
      <p><a href="/login">Login</a> to send a message.</p>
    <% } %>

    <hr/>

  </div>
</body>
</html>

