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

import codeu.model.data.Conversation;
import codeu.model.data.User;
import codeu.model.data.Marker;
import codeu.model.store.basic.ConversationStore;
import codeu.model.store.basic.UserStore;
import codeu.model.store.basic.MarkerStore;
import java.io.IOException;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.Mockito;

public class MapServletTest {

  private MapServlet mapServlet;
  private HttpServletRequest mockRequest;
  private HttpSession mockSession;
  private HttpServletResponse mockResponse;
  private RequestDispatcher mockRequestDispatcher;
  private ConversationStore mockConversationStore;
  private UserStore mockUserStore;
  private MarkerStore mockMarkerStore;

  @Before
  public void setup() {
    mapServlet = new MapServlet();

    mockRequest = Mockito.mock(HttpServletRequest.class);
    mockSession = Mockito.mock(HttpSession.class);
    Mockito.when(mockRequest.getSession()).thenReturn(mockSession);

    mockResponse = Mockito.mock(HttpServletResponse.class);
    mockRequestDispatcher = Mockito.mock(RequestDispatcher.class);
    Mockito.when(mockRequest.getRequestDispatcher("/WEB-INF/view/map.jsp"))
        .thenReturn(mockRequestDispatcher);

    mockConversationStore = Mockito.mock(ConversationStore.class);
    mapServlet.setConversationStore(mockConversationStore);

    mockUserStore = Mockito.mock(UserStore.class);
    mapServlet.setUserStore(mockUserStore);

    mockMarkerStore = Mockito.mock(MarkerStore.class);
    mapServlet.setMarkerStore(mockMarkerStore);
  }

  @Test
  public void testDoGet() throws IOException, ServletException {
    List<Marker> fakeMarkerList = new ArrayList<>();
    fakeMarkerList.add(
        new Marker(UUID.randomUUID(), UUID.randomUUID(), "test_marker", 4.5, 9.1, Instant.now()));
    Mockito.when(mockMarkerStore.getAllMarkers()).thenReturn(fakeMarkerList);

    mapServlet.doGet(mockRequest, mockResponse);

    Mockito.verify(mockRequest).setAttribute("markers", fakeMarkerList);
    Mockito.verify(mockRequestDispatcher).forward(mockRequest, mockResponse);
  }

  @Test
  public void testDoPost_UserNotLoggedIn() throws IOException, ServletException {
    Mockito.when(mockSession.getAttribute("user")).thenReturn(null);
    mapServlet.doPost(mockRequest, mockResponse);

    Mockito.verify(mockConversationStore, Mockito.never())
        .addConversation(Mockito.any(Conversation.class));
    Mockito.verify(mockMarkerStore, Mockito.never())
        .addMarker(Mockito.any(Marker.class));
    Mockito.verify(mockRequest).setAttribute("error", "Please log in to add a new marker.");
    Mockito.verify(mockRequestDispatcher).forward(mockRequest, mockResponse);
  }

  @Test
  public void testDoPost_InvalidUser() throws IOException, ServletException {
    Mockito.when(mockSession.getAttribute("user")).thenReturn("test_username");
    Mockito.when(mockUserStore.getUser("test_username")).thenReturn(null);

    mapServlet.doPost(mockRequest, mockResponse);

    Mockito.verify(mockConversationStore, Mockito.never())
        .addConversation(Mockito.any(Conversation.class));
    Mockito.verify(mockMarkerStore, Mockito.never())
        .addMarker(Mockito.any(Marker.class));
    Mockito.verify(mockResponse).sendRedirect("/map");
  }

  @Test
    public void testDoPost_NoLocationName() throws IOException, ServletException {
        Mockito.when(mockRequest.getParameter("locationName")).thenReturn("");
        Mockito.when(mockSession.getAttribute("user")).thenReturn("test_username");
        
        User fakeUser =
        new User(
                 UUID.randomUUID(),
                 "test_username", "test_aboutMe",
                 "$2a$10$eDhncK/4cNH2KE.Y51AWpeL8/5znNBQLuAFlyJpSYNODR/SJQ/Fg6",
                 Instant.now(), "/About-IMG/Default-Profile-IMG.png");
        Mockito.when(mockUserStore.getUser("test_username")).thenReturn(fakeUser);
        
        mapServlet.doPost(mockRequest, mockResponse);
        
        Mockito.verify(mockConversationStore, Mockito.never())
        .addConversation(Mockito.any(Conversation.class));
        Mockito.verify(mockMarkerStore, Mockito.never())
        .addMarker(Mockito.any(Marker.class));
        Mockito.verify(mockRequest).setAttribute("error", "Please enter at least one letter or number for the location name.");
        Mockito.verify(mockRequestDispatcher).forward(mockRequest, mockResponse);
    }

  @Test
  public void testDoPost_LocationNameTaken() throws IOException, ServletException {
    Mockito.when(mockRequest.getParameter("locationName")).thenReturn("test_locationName");
    Mockito.when(mockSession.getAttribute("user")).thenReturn("test_username");

    User fakeUser =
        new User(
            UUID.randomUUID(),
            "test_username", "test_aboutMe",
            "$2a$10$eDhncK/4cNH2KE.Y51AWpeL8/5znNBQLuAFlyJpSYNODR/SJQ/Fg6",
            Instant.now(), "/About-IMG/Default-Profile-IMG.png");
    Mockito.when(mockUserStore.getUser("test_username")).thenReturn(fakeUser);

    Mockito.when(mockConversationStore.isTitleTaken("test_locationName")).thenReturn(true);

    mapServlet.doPost(mockRequest, mockResponse);

    Mockito.verify(mockConversationStore, Mockito.never())
        .addConversation(Mockito.any(Conversation.class));
    Mockito.verify(mockMarkerStore, Mockito.never())
        .addMarker(Mockito.any(Marker.class));
    Mockito.verify(mockRequest).setAttribute("error", "Location name already taken. Please use a different location name.");
    Mockito.verify(mockRequestDispatcher).forward(mockRequest, mockResponse);
  }

  @Test
  public void testDoPost_InvalidLongLat() throws IOException, ServletException {
    Mockito.when(mockRequest.getParameter("latitudeVal")).thenReturn("abcd");
    Mockito.when(mockRequest.getParameter("longitudeVal")).thenReturn("-11.64566");
    Mockito.when(mockRequest.getParameter("locationName")).thenReturn("test_locationName");
    Mockito.when(mockSession.getAttribute("user")).thenReturn("test_username");

    User fakeUser =
        new User(
            UUID.randomUUID(),
            "test_username", "test_aboutMe",
            "$2a$10$eDhncK/4cNH2KE.Y51AWpeL8/5znNBQLuAFlyJpSYNODR/SJQ/Fg6",
            Instant.now(), "/About-IMG/Default-Profile-IMG.png");
    Mockito.when(mockUserStore.getUser("test_username")).thenReturn(fakeUser);

    Mockito.when(mockConversationStore.isTitleTaken("test_locationName")).thenReturn(false);

    mapServlet.doPost(mockRequest, mockResponse);

    Mockito.verify(mockConversationStore, Mockito.never())
        .addConversation(Mockito.any(Conversation.class));
    Mockito.verify(mockMarkerStore, Mockito.never())
        .addMarker(Mockito.any(Marker.class));
    Mockito.verify(mockRequest).setAttribute("error", "Please enter only numbers/decimals for longitude/latitude values.");
    Mockito.verify(mockRequestDispatcher).forward(mockRequest, mockResponse);
  }

  @Test
  public void testDoPost_NewMarker() throws IOException, ServletException {
    Mockito.when(mockRequest.getParameter("latitudeVal")).thenReturn("4.55555");
    Mockito.when(mockRequest.getParameter("longitudeVal")).thenReturn("-11.64566");
    Mockito.when(mockRequest.getParameter("locationName")).thenReturn("test_locationName");
    Mockito.when(mockSession.getAttribute("user")).thenReturn("test_username");

    User fakeUser =
        new User(
            UUID.randomUUID(),
            "test_username", "test_aboutMe",
            "$2a$10$eDhncK/4cNH2KE.Y51AWpeL8/5znNBQLuAFlyJpSYNODR/SJQ/Fg6",
            Instant.now(), "/About-IMG/Default-Profile-IMG.png");

    Marker fakeMarker =
        new Marker(
            UUID.randomUUID(), UUID.randomUUID(),
            "test_locationName", 4.55555,
            -11.64566,
            Instant.now());


    Mockito.when(mockUserStore.getUser("test_username")).thenReturn(fakeUser);

    Mockito.when(mockMarkerStore.getMarkerByConvo(fakeUser.getId())).thenReturn(fakeMarker);

    Mockito.when(mockConversationStore.isTitleTaken("test_locationName")).thenReturn(false);

    mapServlet.doPost(mockRequest, mockResponse);

    ArgumentCaptor<Conversation> conversationArgumentCaptor =
        ArgumentCaptor.forClass(Conversation.class);
    Mockito.verify(mockConversationStore).addConversation(conversationArgumentCaptor.capture());
    Assert.assertEquals(conversationArgumentCaptor.getValue().getTitle(), "test_locationName");

    ArgumentCaptor<Marker> markerArgumentCaptor =
        ArgumentCaptor.forClass(Marker.class);
    Mockito.verify(mockMarkerStore).addMarker(markerArgumentCaptor.capture());
    Assert.assertEquals(markerArgumentCaptor.getValue().getLatitude(), 4.55555, 0.0);

    Mockito.verify(mockResponse).sendRedirect("/map");
  }
}
