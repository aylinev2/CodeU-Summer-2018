package codeu.controller;

import java.io.IOException;
import java.time.Instant;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mindrot.jbcrypt.BCrypt;

import codeu.model.data.User;
import codeu.model.store.basic.UserStore;

public class RegisterServlet extends HttpServlet {

  /** Store class that gives access to Users. */
  private UserStore userStore;
  private LoginServlet loginServlet;

  /**
   * Set up state for handling registration-related requests. This method is only called when
   * running in a server, not when running in a test.
   */
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

  @Override
  public void doGet(HttpServletRequest request, HttpServletResponse response)
      throws IOException, ServletException {
    request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
  }

  @Override
  public void doPost(HttpServletRequest request, HttpServletResponse response)
      throws IOException, ServletException {

    String username = request.getParameter("username");

    if (!username.matches("[\\w*\\s*]*")) {
      request.setAttribute("error", "Please enter only letters, numbers, and spaces.");
      request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
      return;
    }
          
    if (username.isEmpty()) {
        request.setAttribute("error", "Please enter at least one letter or number for username.");
        request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
        return;
    }


    if (userStore.isUserRegistered(username)) {
      request.setAttribute("error", "That username is already taken.");
      request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
      return;
    }

    String password = request.getParameter("password");
    if (password.isEmpty()) {
        request.setAttribute("error", "Please enter at least one letter or number for password.");
        request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
        return;
    }
    String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

    String defaultAboutMe = "Welcome to " + username + "'s profile!";
    String defaultProfileImg = "https://cdn1.iconfinder.com/data/icons/emoticon-17/128/EMOTION_3-02-512.png";

    User user = new User(UUID.randomUUID(), username, defaultAboutMe, hashedPassword, Instant.now(), defaultProfileImg);
    userStore.addUser(user);

    request.getSession().setAttribute("user", username);
    response.sendRedirect("/map");
  }
}
