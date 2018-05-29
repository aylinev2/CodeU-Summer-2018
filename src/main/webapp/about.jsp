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
  <title>CodeU Chat App</title>
  <link rel="stylesheet" href="/css/main.css">
  <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">

</head>
<body>

  <%@ include file="/WEB-INF/view/navbar.jsp" %>

  <div id="container">
    <div
      style="width:75%; margin-left:auto; margin-right:auto; margin-top: 50px;">

      <h1>About the CodeU Chat App</h1>
      <p>
        This is an example chat application designed to be a starting point
        for your CodeU project team work. Here's some stuff to think about:
      </p>

      <ul>
        <li><strong>Algorithms and data structures:</strong> We've made the app
            and the code as simple as possible. You will have to extend the
            existing data structures to support your enhancements to the app,
            and also make changes for performance and scalability as your app
            increases in complexity.</li>
        <li><strong>Look and feel:</strong> The focus of CodeU is on the Java
          side of things, but if you're particularly interested you might use
          HTML, CSS, and JavaScript to make the chat app prettier.</li>
        <li><strong>Customization:</strong> Think about a group you care about.
          What needs do they have? How could you help? Think about technical
          requirements, privacy concerns, and accessibility and
          internationalization.</li>
      </ul>

      <p> <br>
        <strong>Meet the Team!</strong>
        <ul>
          <div class="social-icons">
            <table cellpadding = "15" cellspacing = "1">
              <tr><td align="center"><img src="About-IMG/Default-Profile-IMG.png" class="prof-pic">
                <a href="https://github.com/MarcelRG"><i class="fa fa-github"></i></a>

                <a href="ADD LINK HERE!!!!"><i class="fa fa-linkedin-square"></i></a>

                </td>
                <td><strong>Marcel Gonzalez</strong>
                Currently studying Computer Science at Tecnologico de Monterrey</td></tr>
              

              <tr><td align="center" ><img src="About-IMG/Ayline-Profile.gif" class="prof-pic">
                <a href="https://www.facebook.com/ayline.villegas"><i class="fa fa-facebook-square"></i></a>

                <a href="https://www.instagram.com/ayline_villegas/"><i class="fa fa-instagram"></i></a>

                <a href="https://github.com/aylinev2"><i class="fa fa-github"></i></a>

                <a href="https://www.linkedin.com/in/aylinev/"><i class="fa fa-linkedin-square"></i></a>

                </td>
                <td><a href="http://aylinev2.github.io"><strong>Ayline Villegas</strong></a>
                Currently studying Computer Science at The University of Illinois at Urbana Champaign. Passions include: cats, baking, and music!</td></tr>


              <tr><td align="center"><img src="About-IMG/Anthony-Profile-IMG.jpg" class="prof-pic">
                <a href="https://www.facebook.com/anthony.beltran.7796"><i class="fa fa-facebook-square"></i></a>

                <a href="https://github.com/abeltran1804"><i class="fa fa-github"></i></a>

                <a href="https://www.linkedin.com/in/abeltran1804/"><i class="fa fa-linkedin-square"></i></a>

                </td>
                <td><strong>Anthony Beltran</strong>
                Currently studying Computer Science at The University of Illinois at Chicago. Passions include: nature, AI, and food!
              </td></tr>
            </table>
          </div>
        </ul>
      </p>
    </div>
  </div>
</body>
</html>
