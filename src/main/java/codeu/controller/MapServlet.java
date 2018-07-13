package codeu.controller;

import codeu.model.data.User;
import codeu.model.store.basic.UserStore;
import codeu.model.data.Conversation;
import codeu.model.store.basic.ConversationStore;
import codeu.model.data.Marker;
import java.io.IOException;
import java.time.Instant;
import java.util.List;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/** Servlet class responsible for the map. */
public class MapServlet extends HttpServlet{

  /** Store class that gives access to Users. */
  private UserStore userStore;

  /** Store class that gives access to Conversations. */
  private ConversationStore conversationStore;

  /** Store class that gives access to Markers. */
  //private MarkerStore markerStore;

  /** Set up state for handling map with markers. */
  @Override
  public void init() throws ServletException {
    super.init();
    //setMarkerStore(MarkerStore.getInstance());
    setUserStore(UserStore.getInstance());
    setConversationStore(ConversationStore.getInstance());
  }

  /**
   * Sets the UserStore used by this servlet. This function provides a common setup method for use
   * by the test framework or the servlet's init() function.
   */
  void setUserStore(UserStore userStore) {
    this.userStore = userStore;
  }

  /**
   * Sets the ConversationStore used by this servlet. This function provides a common setup method for use
   * by the test framework or the servlet's init() function.
   */
  void setConversationStore(ConversationStore conversationStore) {
    this.conversationStore = conversationStore;
  }

  /**
   * Sets the MarkerStore used by this servlet. This function provides a common setup method for use
   * by the test framework or the servlet's init() function.
   */
 // void setMarkerStore(MarkerStore markerStore) {
 //   this.markerStore = markerStore;
 // }

  /**
   * This function fires when a user navigates to the map.
   */
  @Override
  public void doGet(HttpServletRequest request, HttpServletResponse response)
      throws IOException, ServletException {
        request.getRequestDispatcher("/WEB-INF/view/map.jsp").forward(request, response);
  }

  
  @Override
  public void doPost(HttpServletRequest request, HttpServletResponse response)
      throws IOException, ServletException {
      String username = (String) request.getSession().getAttribute("user");
    if (username == null) {
      request.setAttribute("error", "Please log in to add a new marker.");
      request.getRequestDispatcher("/WEB-INF/view/map.jsp").forward(request, response);
      return;
    }

    User user = userStore.getUser(username);
    if (user == null) {
      // user was not found, don't let them create a new marker and conversation
      System.out.println("User not found: " + username);
      response.sendRedirect("/map");
      return;
    }

    String locName = request.getParameter("locationName");
    if (locName.isEmpty()) {
        request.setAttribute("error", "Please enter at least one letter or number for the location name.");
        List<Conversation> conversations = conversationStore.getAllConversations();
        request.setAttribute("conversations", conversations);
        request.getRequestDispatcher("/WEB-INF/view/map.jsp").forward(request, response);
        return;
    }

    if (conversationStore.isTitleTaken(locName)) {
      // location name is already taken, don't let them add new marker with that name
      request.setAttribute("error", "Location name already taken. Please use a different location name.");
      request.getRequestDispatcher("/WEB-INF/view/map.jsp").forward(request, response);
      return;
    }

    String latval = request.getParameter("latitudeVal");
    String longval = request.getParameter("longitudeVal");
    double lat;
    double lng;
    
    try {
       lat = Double.parseDouble(latval);
       lng = Double.parseDouble(longval);
    }
    catch(NumberFormatException e) {
      request.setAttribute("error", "Please enter only numbers/decimals for longitude/latitude values.");
      request.getRequestDispatcher("/WEB-INF/view/map.jsp").forward(request, response);
      return;
    }

    Conversation conversation =
        new Conversation(UUID.randomUUID(), user.getId(), locName, Instant.now());
    
    Marker marker = new Marker(conversation, lat, lng);

    conversationStore.addConversation(conversation);

    // redirect to a GET request
    response.sendRedirect("/map");
  }
  
}