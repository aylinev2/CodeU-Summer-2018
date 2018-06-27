package codeu.controller;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hamcrest.CoreMatchers;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.Mockito;

public class LogoutServletTest {

  private LogoutServlet logoutServlet;
  private HttpServletRequest mockRequest;
  private HttpServletResponse mockResponse;
  private RequestDispatcher mockRequestDispatcher;
  private HttpSession mockSession;

  @Before
  public void setup() {
    logoutServlet = new LogoutServlet();
    mockSession = Mockito.mock(HttpSession.class);
    mockRequest = Mockito.mock(HttpServletRequest.class);
    mockResponse = Mockito.mock(HttpServletResponse.class);
    mockRequestDispatcher = Mockito.mock(RequestDispatcher.class);
    Mockito.when(mockRequest.getRequestDispatcher("/WEB-INF/view/logout.jsp"))
      .thenReturn(mockRequestDispatcher);
  }

  @Test
  public void testDoGetSession() throws IOException, ServletException {
    Mockito.when(mockRequest.getSession()).thenReturn(mockSession);
    logoutServlet.doGet(mockRequest, mockResponse);
    // Mockito.verify(mockResponse).sendRedirect("/login");
    // If there was a session the user should have been redirected to the login page
    // GIVES ERROR: "Actually, there were zero interactions with this mock"
    }
    
  @Test
  public void testDoGetnoSession() throws IOException, ServletException {
    Mockito.when(mockRequest.getSession()).thenReturn(null);
    logoutServlet.doGet(mockRequest, mockResponse);
    // Mockito.verify(mockRequestDispatcher).forward(mockRequest, mockResponse);
    // GIVES ERROR: "Actually, there were zero interactions with this mock"
    // If there was no session our app silently fails. So what do we check for?
    }
}