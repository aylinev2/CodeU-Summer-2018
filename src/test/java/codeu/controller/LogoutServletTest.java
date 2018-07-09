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
    mockRequest = Mockito.mock(HttpServletRequest.class);
    mockSession = Mockito.mock(HttpSession.class);
    mockResponse = Mockito.mock(HttpServletResponse.class);
    mockRequestDispatcher = Mockito.mock(RequestDispatcher.class);
    Mockito.when(mockRequest.getRequestDispatcher("/WEB-INF/view/login.jsp"))
      .thenReturn(mockRequestDispatcher);
  }

  @Test
  public void testDoGetSession() throws IOException, ServletException {
    Mockito.when(mockRequest.getSession(false)).thenReturn(mockSession);
    Mockito.when(mockSession.getAttribute("user")).thenReturn("testUser");
    logoutServlet.doGet(mockRequest, mockResponse);
    Mockito.verify(mockRequest).setAttribute("error", "Logout successful!");
    Mockito.verify(mockRequestDispatcher).forward(mockRequest, mockResponse);
  }
    
  @Test
  public void testDoGetnoSession() throws IOException, ServletException {
    Mockito.when(mockRequest.getSession(false)).thenReturn(null);
    logoutServlet.doGet(mockRequest, mockResponse);
    Assert.assertEquals(null, mockRequest.getAttribute("error"));
    }
}
