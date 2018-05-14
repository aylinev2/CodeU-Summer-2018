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
</head>
<body>

  <nav>
    <a id="navTitle" href="/">CodeU Chat App</a>
    <a href="/conversations">Conversations</a>
    <% if(request.getSession().getAttribute("user") != null){ %>
      <a>Hello <%= request.getSession().getAttribute("user") %>!</a>
    <% } else{ %>
      <a href="/login">Login</a>
    <% } %>
    <a href="/about.jsp">About</a>
  </nav>

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
        	
        		 <img src="Default-Profile-IMG.png" width = "150" height = "150" style = "float:left"> 
        		<li> <strong>Marcel Gonzalez</strong>
        		Currently studying Computer Science at Tecnologico de Monterrey </li> <br> <br> <br>

       
        		<br> <img src="Default-Profile-IMG.png" width = "150" height = "150" style = "float:left"> 
        		<li> <strong>Ayline Villegas</strong>
        		Currently studying Computer Science at The University of Illinois at Urbana Champaign </li> <br> <br> <br>


        		<br> <img src="Anthony-Profile-IMG.jpg" width = "150" height = "150" style = "float:left;border-radius:50%""> 
        		<li> <strong>Anthony Beltran</strong> 
        		Currently studying Computer Science at The University of Illinois at Chicago. Passions include: nature, AI, and food! <a href = "https://www.linkedin.com/in/abeltran1804/">linkedin</a> </li> <br> <br> <br>
        </ul>
      </p>
    </div>
  </div>
</body>
</html>
