<%@ page import= "java.util.UUID" %>
<%@ page import="codeu.model.data.User" %>
<%@ page import="codeu.model.data.Message" %>
<%@ page import="codeu.model.data.Marker" %>
<%@ page import= "java.util.HashMap" %>
<%@ page import= "java.util.Map" %>
<%@ page import="codeu.model.store.basic.UserStore" %>
<%@ page import="codeu.model.store.basic.MessageStore" %>
<%@ page import="codeu.model.store.basic.MarkerStore" %>
<%@ page import="org.kefirsf.bb.BBProcessorFactory" %>
<%@ page import="org.kefirsf.bb.TextProcessor" %>
<%@ page import="java.util.List" %>
<%@ page import= "java.time.format.DateTimeFormatter" %>
<%@ page import= "java.util.Date" %>
<%@ page import= "java.time.LocalDateTime" %>
<%@ page import= "java.time.ZoneId" %>
<%@ page import= "java.time.format.FormatStyle" %>
<%@ page import= "java.util.Locale" %>
<%@ page import= "java.time.Instant" %>
<%@ page import= "com.vdurmont.emoji.EmojiParser" %>

<%
User user = (User) request.getAttribute("userToAccess");
String loggedInUserename = (String) request.getSession().getAttribute("user");
User loggedInUser = UserStore.getInstance().getUser(loggedInUserename);
MarkerStore mkrStore = MarkerStore.getInstance();
// processor needed for BBCode to HTML translation
TextProcessor processor = BBProcessorFactory.getInstance().createFromResource("kefirbb.xml");
DateTimeFormatter formatter = DateTimeFormatter.ofLocalizedDateTime(FormatStyle.SHORT).withLocale(Locale.US).withZone(ZoneId.systemDefault());
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title><%= user.getName() %>'s Profile Page</title>
  <link rel="stylesheet" href="/css/main.css">
  <script>
    // scroll the chat div to the bottom
    function scrollActivity() {
      var activityDiv = document.getElementById('activity');
      activityDiv.scrollTop = activityDiv.scrollHeight;
    };
  </script>
</head>
<body onload="scrollActivity()">

  <%@ include file="/WEB-INF/view/navbar.jsp" %>

  <div id="container">
  <div style="text-align: center;">
      <h1><%= user.getName() %>'s Profile Page</h1>
      <hr/>
      <img src="<%=user.getPic()%>" class="prof-pic">
      <h2>About <%= user.getName()%></h2>
      <p>
        <%= processor.process(user.getAboutMe())%>
      </p>

      <% if(request.getSession().getAttribute("error") != null) { %>
       <h2 style="color:red"><%= request.getSession().getAttribute("error") %></h2>
        <% request.getSession().setAttribute("error", null); } %>
    <% if (loggedInUser != null && loggedInUser.getName().equals(user.getName())) { %>
    <br>
      <form action="/profile/<%= user.getPic() %>" method="POST">
        <p>Enter link to new profile picture: <input type="text" name="profilePic" id="profilePic"> <button type="submit">Submit</button> <p> 
    </form>
    <h2>Edit your About Me (Only you can see this)</h2>

    <form action="/profile/<%= user.getName() %>" method="POST">
        <textarea class="text-box" name="info" cols="60" rows="5"><%= user.getAboutMe()%>
        </textarea>
        <br/>
        <button type="submit">Submit</button>
        <br>
        <p> Our chat app currently supports BBCode for text styling. <a id="ul-link" href="/guide.jsp">Click here</a> to learn more about our text styling options.</p>
    </form>
     <% } %>

     <hr/>
     <h2><%= user.getName()%>'s Sent Messages</h2>
     
     </div>
     <div id="activity">
      <ul>
     <%
      List<Message> messages = MessageStore.getInstance().getMessagesByAuthor(user.getId());
      if(messages == null || messages.isEmpty()){
      %>
        <p>Aww nothing so far!</p>
      <%
      }
      else{
      for (Message message : messages) {
          Marker mkr = mkrStore.getMarkerByConvo(message.getConversationId());
          if (mkr != null){
            String mkrName = EmojiParser.parseToUnicode(mkr.getLocationName());
            String convoName = mkrName.replaceAll("\\s", "");
         %>
         <li><b><%= formatter.format(message.getCreationTime()) %> in <a id="link" href="/chat/<%= convoName%>"><%= mkrName%></a>: </b> <%= message.getContent() %>
        <% 
         }
      }
    }
      %>
    </li>
    </ul>
    </div>
    <hr/>
    <br>
  </div>
</body>
</html>