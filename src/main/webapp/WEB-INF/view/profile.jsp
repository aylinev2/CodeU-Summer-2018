<%@ page import="codeu.model.data.User" %>
<%@ page import="codeu.model.store.basic.UserStore" %>
<%@ page import="org.kefirsf.bb.BBProcessorFactory" %>
<%@ page import="org.kefirsf.bb.TextProcessor" %>


<%
User user = (User) request.getAttribute("userToAccess");
String loggedInUserename = (String) request.getSession().getAttribute("user");
User loggedInUser = UserStore.getInstance().getUser(loggedInUserename);
// processor needed for BBCode to HTML translation
TextProcessor processor = BBProcessorFactory.getInstance().createFromResource("kefirbb.xml");
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title><%= user.getName() %>'s Profile Page</title>
  <link rel="stylesheet" href="/css/main.css">
</head>
<body>

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

  </div>
</body>
</html>