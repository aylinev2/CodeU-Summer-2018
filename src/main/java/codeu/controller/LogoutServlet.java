// Copyright 2017 Google Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package codeu.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/** Servlet class responsible for the logout page. */
public class LogoutServlet extends HttpServlet {
  /** Set up state for handling profile pages. */
  @Override
  public void init() throws ServletException {
    super.init();
  }
    
  @Override
  public void doGet(HttpServletRequest request, HttpServletResponse response)
      throws IOException, ServletException {
    
    HttpSession session = request.getSession(false);
    String user = (session != null) ? (String) session.getAttribute("user") : null;
    if(user != null){
      request.setAttribute("error", "Logout successful!");
      request.getSession(false).invalidate();
      request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
      }
  }
}
