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

   <%@ include file="/WEB-INF/view/navbar.jsp" %>

  <div id="container">
    <div
      style="width:75%; margin-left:auto; margin-right:auto; margin-top: 50px;">

      <h1>Team AMA's Chat App</h1>
      <h2>Welcome!</h2>

      <ul>
        <li><a id="ul-link" href="/login">Login</a> to get started.</li>
        <li>Go to the <a id="ul-link" href="/map">map</a> page to
            find or create a new conversation at a certain location.</li>
        <li>View the <a id="ul-link" href="/about.jsp">about</a> page to learn more about the
            project and the team behind it!</li>
      </ul>
    </div>
  </div>
</body>
</html>
