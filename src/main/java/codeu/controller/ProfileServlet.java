package codeu.controller;

import codeu.model.data.User;
import codeu.validate.ImageValidator;
import codeu.model.store.basic.UserStore;
import java.io.IOException;
import java.time.Instant;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.jsoup.Jsoup;
import org.jsoup.safety.Whitelist;
import org.kefirsf.bb.BBProcessorFactory;
import org.kefirsf.bb.TextProcessor;
import com.vdurmont.emoji.EmojiParser;

/** Servlet class responsible for a profile page. */
public class ProfileServlet extends HttpServlet{

  /** Store class that gives access to Users. */
  private UserStore userStore;
  private ImageValidator imageValidator;

  /** Set up state for handling profile pages. */
  @Override
  public void init() throws ServletException {
    super.init();
    imageValidator = new ImageValidator();
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
        request.setAttribute("userToAccess", user);
        request.getRequestDispatcher("/WEB-INF/view/profile.jsp").forward(request, response);
  }

  
  @Override
  public void doPost(HttpServletRequest request, HttpServletResponse response)
      throws IOException, ServletException {
        String username = (String) request.getSession().getAttribute("user");
    if (username == null) {
      // user is not logged in, don't let them edit profile
      return;
    }

    User user = userStore.getUser(username);
    if (user == null) {
      // user was not found, don't let them edit profile
      return;
    }

    if(request.getParameter("info") != null){
        // processor needed for BBCode to HTML translation
        TextProcessor processor = BBProcessorFactory.getInstance().createFromResource("kefirbb.xml");
        String messageContent = request.getParameter("info");
        // this removes any HTML from the message content and then parses any BBCode to HTML
        String cleanedMessageContent = Jsoup.clean(messageContent, Whitelist.none());
        String cleanedAndEmojiCheckedMsg = EmojiParser.parseToUnicode(cleanedMessageContent);
        user.setAboutMe(cleanedAndEmojiCheckedMsg);
        userStore.updateUser(user);
        // redirect to a GET request
        response.sendRedirect("/profile/" + username);
        return;
    }
          
    if(request.getParameter("profilePic") != null){
        String picURL = request.getParameter("profilePic");
        boolean valid = imageValidator.validate(picURL);
        if(valid){
            user.setProfilePic(picURL);
            userStore.updateUser(user);
            response.sendRedirect("/profile/" + username);
            return;
        }
        else {
            request.getSession().setAttribute("error", "Oops bad URL");
            response.sendRedirect("/profile/" + username);
            return;
        }
    }
  }
}
