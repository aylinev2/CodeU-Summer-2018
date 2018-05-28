package codeu.controller;

import codeu.model.data.User;
import codeu.model.store.basic.UserStore;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mindrot.jbcrypt.BCrypt;

/** Servlet class responsible for the admin page. */
public class AdminServlet extends HttpServlet {

    /** Store class that gives access to Users. */
    private UserStore userStore;

    /**
     * Set up state for handling login-related requests. This method is only called when running in a
     * server, not when running in a test.
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

        String username = (String) request.getSession().getAttribute("user");
        User user = userStore.getUser(username);
        if (user == null) {
            request.setAttribute("error", "Log in with an admin account.");
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
            return;
        }
        if(userStore.hasAdmin(username)){
            request.getRequestDispatcher("/WEB-INF/view/admin.jsp").forward(request, response);
            return;
        } else{
            request.setAttribute("error", "Please log in with a valid admin account");
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
        }
    }
}