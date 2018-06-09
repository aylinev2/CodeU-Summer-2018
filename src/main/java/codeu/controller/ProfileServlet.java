package codeu.controller;

import codeu.model.data.User;
import codeu.model.store.basic.UserStore;
import java.io.IOException;
import java.time.Instant;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/** Servlet class responsible for a profile page. */
public class ProfileServlet extends HttpServlet{

  /** Store class that gives access to Users. */
  private UserStore userStore;

  /** Set up state for handling profile pages. */
  @Override
  public void init() throws ServletException {
    super.init();
    setUserStore(UserStore.getInstance());
  }

  /**
   * Sets the UserStore used by this servlet. This function provides a common setup method for use
   * by the test framework or the servlet's init() function.
   */
  void setUserStore(UserStore userStore) {
    this.userStore = userStore;
  }

  /**
   * This function fires when a user navigates to a profile page. It gets the designated user from
   * the URL, finds the corresponding profile, and fetches the profile.
   * It then forwards to profile.jsp for rendering.
   */
  @Override
  public void doGet(HttpServletRequest request, HttpServletResponse response)
      throws IOException, ServletException {
        String requestUrl = request.getRequestURI();
        String username = (requestUrl.substring("/profile".length())).replace("/", "");

        User user = userStore.getUser(username);

        if (user == null) {
        // if user doesn't exist, send to chat homepage 
          System.out.println("User '" + username + "' was not found");
          response.sendRedirect("/");
          return;

        }
        request.setAttribute("user", user);
        request.getRequestDispatcher("/WEB-INF/view/profile.jsp").forward(request, response);
  }

  
  @Override
  public void doPost(HttpServletRequest request, HttpServletResponse response)
      throws IOException, ServletException {
        
  }
}