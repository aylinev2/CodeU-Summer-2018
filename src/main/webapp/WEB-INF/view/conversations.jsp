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
<%@ page import="codeu.model.data.Marker" %>
<%@ page import="com.vdurmont.emoji.EmojiParser" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Conversations</title>
  <link rel="stylesheet" href="/css/main.css">
</head>
<body>

  <%@ include file="navbar.jsp" %>

  <div id="container">

    <h1>Conversations</h1>

    <%
    List<Marker> markers =
      (List<Marker>) request.getAttribute("markers");
    if(markers == null || markers.isEmpty()){
    %>
      <p>Create a conversation to get started. Visit the <a href="/map">map</a> page to start a new conversation.</p>
    <%
    }
    else{
    %>
      <ul class="mdl-list">
    <%
      for(Marker marker: markers){
      String convoName = marker.getLocationName().replaceAll("\\s", "");
    %>
      <li><a id="link" href="/chat/<%= convoName %>">
        <%= EmojiParser.parseToUnicode(marker.getLocationName()) %></a></li>
    <%
      }
    %>
      </ul>
      Log in and visit the <a id="ul-link" href="/map">map</a> page to start a new conversation.
    <%
    }
    %>
    <hr/>
  </div>
</body>
</html>
