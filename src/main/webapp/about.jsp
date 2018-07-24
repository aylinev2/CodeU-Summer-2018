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
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>CodeU Chat App</title>
  <link rel="stylesheet" href="/css/main.css">
  <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">

</head>
<body>

  <%@ include file="/WEB-INF/view/navbar.jsp" %>

  <div id="container">
    <div
      style="margin-left:auto; margin-right:auto; margin-top: 50px;">

      <h1>About Team AMA's Chat App</h1>
      <p>
        Welcome to our chat application! Our chat app allows users to connect through conversations that are started at different locations on a google map. We wanted the map to be the focal point of our app so we turned it into a way for a user to join or start a conversation. Our chat app also has some other features that include:
      </p>
      <ul>
        <li><strong>Activity Feed:</strong> A feed that shows all of the application's activity such as when users start conversations, write messages, or join the application.</li>
        <li><strong>Profile Pages:</strong> Pages that display a user's about me, profile picture, and a mini feed that includes all of the messages a user has sent. When logged in, users have the option to edit their about me and picture right from their profile page.</li>
        <li><strong>Text Styling:</strong> The ability to style text by using certain BBCode tags ([b]wow![/b] -> <b>wow!</b>) or parse text to emojis (:cat: -> &#x1F431;). Our website also has a <a id="ul-link" href="/guide.jsp">text styling guide</a> available for those who aren't familiar with BBCode tags and would like to learn how to use them on our site. </li>
      </ul>

      <p> <br>
        <strong>Meet the Team!</strong>
        <ul>
          <div class="social-icons">
            <table cellpadding = "15" cellspacing = "1">
              <tr><td align="center" ><img src="About-IMG/Ayline-Profile.gif" class="prof-pic">
                <a href="https://www.facebook.com/ayline.villegas"><i class="fa fa-facebook-square"></i></a>

                <a href="https://www.instagram.com/ayline_villegas/"><i class="fa fa-instagram"></i></a>

                <a href="https://github.com/aylinev2"><i class="fa fa-github"></i></a>

                <a href="https://www.linkedin.com/in/aylinev/"><i class="fa fa-linkedin-square"></i></a>

                </td>
                <td><a id="link" href="http://aylinev2.github.io"><strong>Ayline Villegas:</strong></a>
                Currently studying Computer Science at The University of Illinois at Urbana Champaign. Hobbies include: taking pictures of my cats, baking, and playing a lot of sims!</td></tr>


              <tr><td align="center"><img src="About-IMG/Anthony-Profile-IMG.jpg" class="prof-pic">
                <a href="https://www.facebook.com/anthony.beltran.7796"><i class="fa fa-facebook-square"></i></a>

                <a href="https://github.com/abeltran1804"><i class="fa fa-github"></i></a>

                <a href="https://www.linkedin.com/in/abeltran1804/"><i class="fa fa-linkedin-square"></i></a>

                </td>
                <td><strong>Anthony Beltran:</strong>
                Currently studying Computer Science at The University of Illinois at Chicago. Passions include: nature, AI, and food!
              </td></tr>


              <tr><td align="center"><img src="About-IMG/Default-Profile-IMG.png" class="prof-pic">
                </td>
                <td><strong>Marcel Gonzalez:</strong>
                Currently studying Computer Science at Tecnologico de Monterrey</td></tr>

              <tr><td align="center"><img src="About-IMG/Aaron-Profile.jpg" class="prof-pic">
                </td>
                <td><strong>Aaron Colwell - PA:</strong>
                Our super amazing project advisor who gave us so much support!</td></tr>

            </table>
          </div>
        </ul>
      </p>
    </div>
  </div>
</body>
</html>
