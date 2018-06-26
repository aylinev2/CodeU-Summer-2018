<%@ page import= "java.util.UUID" %>
<%@ page import="codeu.model.data.User" %>
<%@ page import="codeu.model.data.Message" %>
<%@ page import= "java.util.HashMap" %>
<%@ page import= "java.util.Map" %>
<%@ page import="codeu.model.store.basic.UserStore" %>
<%@ page import="codeu.model.store.basic.MessageStore" %>
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

<%
User user = (User) request.getAttribute("userToAccess");
String loggedInUserename = (String) request.getSession().getAttribute("user");
User loggedInUser = UserStore.getInstance().getUser(loggedInUserename);
List<Message> messages = MessageStore.getInstance().getMessagesByAuthor(user.getId());
// processor needed for BBCode to HTML translation
TextProcessor processor = BBProcessorFactory.getInstance().createFromResource("kefirbb.xml");
DateTimeFormatter formatter = DateTimeFormatter.ofLocalizedDateTime(FormatStyle.LONG).withLocale(Locale.US).withZone(ZoneId.systemDefault());
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

    <h1><%= user.getName() %>'s Profile Page</h1>

    <hr/>

      <h2>About <%= user.getName()%></h2>
      <p>
        <%= processor.process(user.getAboutMe())%>
      </p>

    <% if (loggedInUser != null && loggedInUser.getName().equals(user.getName())) { %>

    <h2>Edit your About Me (Only you can see this)</h2>

    <form action="/profile/<%= user.getName() %>" method="POST">
        <textarea id="about-me" name="info" cols="60" rows="5"><%= user.getAboutMe()%>
        </textarea>
        <br/>
        <button type="submit">Submit</button>
        <br>
        <p> Our chat app currently supports BBCode for text styling. <a href="/guide.jsp">Click here</a> to learn more about our text styling options.</p>
    </form>
     <% } %>

     <hr/>
     <h2><%= user.getName()%>'s Sent Messages</h2>
     
     <div id="activity">
      <ul>
     <%
      for (Message message : messages) {
        String author = UserStore.getInstance().getUser(message.getAuthorId()).getName();
         %>
         <li><b> <%= author %> <%= formatter.format(message.getCreationTime()) %> : </b> <%= message.getContent() %>
        <% 
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