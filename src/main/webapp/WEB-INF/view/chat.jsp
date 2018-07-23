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
<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<%@ page import="java.util.List" %>
<%@ page import="codeu.model.data.Conversation" %>
<%@ page import="codeu.model.data.Message" %>
<%@ page import="codeu.model.data.Marker" %>
<%@ page import="codeu.model.data.User" %>
<%@ page import="codeu.model.store.basic.UserStore" %>
<%@ page import="codeu.model.store.basic.MessageStore" %>
<%@ page import="codeu.model.store.basic.MarkerStore" %>
<%@ page import="com.vdurmont.emoji.EmojiParser" %>
<%@ page import= "java.time.format.DateTimeFormatter" %>
<%@ page import= "java.util.Date" %>
<%@ page import= "java.time.LocalDateTime" %>
<%@ page import= "java.time.ZoneId" %>
<%@ page import= "java.time.Instant" %>
<%@ page import= "java.time.format.FormatStyle" %>
<%@ page import= "java.util.Locale" %>
<%
DateTimeFormatter formatter = DateTimeFormatter.ofLocalizedDateTime(FormatStyle.SHORT).withLocale(Locale.US).withZone(ZoneId.systemDefault());
Conversation conversation = (Conversation) request.getAttribute("conversation");
List<Message> messages = (List<Message>) request.getAttribute("messages");
Marker mkr = MarkerStore.getInstance().getMarkerByConvo(conversation.getId());
String locName = EmojiParser.parseToUnicode(mkr.getLocationName());
double lat = mkr.getLatitude();
double lng = mkr.getLongitude();
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title><%= locName %></title>
  <link rel="stylesheet" href="/css/main.css" type="text/css">

  <style>
    form.hide {display: none;}

    #chat {
      background-color: white;
      height: 500px;
      overflow-y: scroll
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

    <h1><%= locName %>
      <a href="" style="float: right">&#8635;</a></h1>
      Location: (Latitude: <%= lat %>, Longitude: <%= lng %>)
    <hr/>

    <div id="chat">
      <ul>
    <%
      for (Message message : messages) {
        String author = UserStore.getInstance()
        .getUser(message.getAuthorId()).getName();
        User user = (User) UserStore.getInstance().getUser(author); 
    %>

      <ul class="img-comment-list">
        <li>
          <div class="comment-img">
              <img src="<%=user.getPic()%>">
          </div>
          <div class="comment-text">
              <strong><a id="link" href="/profile/<%= author%>"><%= author%></a></strong>
              <p><%= message.getContent() %></p><p style="font-size:9px"><%=formatter.format(message.getCreationTime()) %></p>
          </div>
          </li>
      </ul>
      
      <% 
      List<Message> replies = MessageStore.getInstance().getRepliesInMessage(message.getId());
      if( replies != null) {
        for(Message reply: replies) {
        User replyAuth = UserStore.getInstance()
        .getUser(reply.getAuthorId());
        String replyAuthor = replyAuth.getName();
      %>
      <p>
        <ul class="img-comment-list" style="margin-left: 60px">
        <li>
        <div class="comment-img">
              <img src="<%=replyAuth.getPic()%>">
        </div>
        <div class="comment-text">
              <strong><a id="link" href="/profile/<%= replyAuthor%>"><%= replyAuthor%></a></strong>
              <p><%= reply.getContent()%></p><p style="font-size:9px"><%=formatter.format(reply.getCreationTime()) %></p>
        </div>
        </li>
        </ul>
      </p>
    <%
      }
    }
    %>
      
    <%
     if (request.getSession().getAttribute("user") != null) { %> 
      <form action="/chat/<%= conversation.getTitle() %>" method="POST" id="replyForm">
        <input type="hidden" name="parentMessageId" value="<%= message.getId().toString() %>" />
        <input type="text" name="message"> 
        <button onclick="toggleReply('test')">Reply</button>
     </form>
      <% 
      }
    } 
    %>
      </ul>
    </div>

    <hr/>

    <% if (request.getSession().getAttribute("user") != null) { %>
    <form action="/chat/<%= conversation.getTitle() %>" method="POST">
        <input type="text" name="message">
        <button type="submit">Send</button>
        <br>
        <p> Our chat app currently supports BBCode for text styling. <a id="ul-link" href="/guide.jsp">Click here</a> to learn more about our text styling options.</p>
    </form> 
    <form action="/chat/<%= conversation.getTitle() %>" method="POST" id="replyForm" class="hide">
        <p id="replyingTo"></p>
        <input type="hidden" name="messageUUID"/>
        <input type="text" name="reply">
        <button type="submit">Reply</button>
      </form>
    <% } else { %>
      <p><a id="ul-link" href="/login">Login</a> to send a message.</p>
    <% } %>

    <hr/>

  </div>
</body>
</html>

