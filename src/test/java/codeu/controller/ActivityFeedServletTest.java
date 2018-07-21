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
import codeu.model.data.Message;
import codeu.model.store.basic.ConversationStore;
import codeu.model.store.persistence.PersistentStorageAgent;
import codeu.model.store.basic.UserStore;
import codeu.model.store.basic.MessageStore;
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
import java.util.HashMap;
import java.util.Map;

public class ActivityFeedServletTest {
    
    private ActivityFeedServlet activityFeedServlet;
    private ConversationServlet conversationServlet;
    private HttpServletRequest mockRequest;
    private HttpSession mockSession;
    private HttpServletResponse mockResponse;
    private RequestDispatcher mockRequestDispatcher;
    private ConversationStore mockConversationStore;
    private UserStore mockUserStore;
    private MessageStore mockMessageStore;
    private PersistentStorageAgent mockPersistentStorageAgent;

    private final User USER_ONE =
      new User(
          UUID.randomUUID(),
          "test_username_one", "test_aboutMe",
          "$2a$10$/zf4WlT2Z6tB5sULB9Wec.QQdawmF0f1SbqBw5EeJg5uoVpKFFXAa",
          Instant.ofEpochMilli(1000), "/About-IMG/Default-Profile-IMG.png");
    
    @Before
    public void setup() {
        activityFeedServlet = new ActivityFeedServlet();
        
        mockRequest = Mockito.mock(HttpServletRequest.class);
        mockSession = Mockito.mock(HttpSession.class);
        Mockito.when(mockRequest.getSession()).thenReturn(mockSession);
        
        mockResponse = Mockito.mock(HttpServletResponse.class);
        mockRequestDispatcher = Mockito.mock(RequestDispatcher.class);
        Mockito.when(mockRequest.getRequestDispatcher("/WEB-INF/view/activity.jsp"))
        .thenReturn(mockRequestDispatcher);
        
        mockConversationStore = Mockito.mock(ConversationStore.class);
        activityFeedServlet.setConversationStore(mockConversationStore);

        mockPersistentStorageAgent = Mockito.mock(PersistentStorageAgent.class);
        mockUserStore = UserStore.getTestInstance(mockPersistentStorageAgent);
        
        mockUserStore = Mockito.mock(UserStore.class);
        activityFeedServlet.setUserStore(mockUserStore);
        
        mockMessageStore = Mockito.mock(MessageStore.class);
        activityFeedServlet.setMessageStore(mockMessageStore);
    }
    
    @Test
    public void testDoGet() throws IOException, ServletException {
        UUID testUUID = UUID.randomUUID();
        HashMap<UUID, String> idToName = new HashMap<>();
        idToName.put(USER_ONE.getId(), USER_ONE.getName());
        
        HashMap<UUID, String> idToTitle = new HashMap<>();
        idToTitle.put(testUUID, "test_conversation");
        
        List<Conversation> fakeConversationList = new ArrayList<>();
        fakeConversationList.add( new Conversation(testUUID, USER_ONE.getId(), "test_conversation", Instant.now()));
        Mockito.when(mockConversationStore.getAllConversations()).thenReturn(fakeConversationList);
        
        List<Message> fakeMessageList = new ArrayList<>();
        fakeMessageList.add(new Message(UUID.randomUUID(), UUID.randomUUID(), UUID.randomUUID(), "test message", Instant.now(), UUID.randomUUID()));
        Mockito.when(mockMessageStore.getAllMessages()).thenReturn(fakeMessageList);
        
        final List<User> userList = new ArrayList<>();
        userList.add(USER_ONE);
        Mockito.when(mockUserStore.getAllUsers()).thenReturn(userList);
        
        activityFeedServlet.doGet(mockRequest, mockResponse);
        
        Mockito.verify(mockRequest).setAttribute("conversations", fakeConversationList);
        Mockito.verify(mockRequest).setAttribute("users", userList);
        Mockito.verify(mockRequest).setAttribute("idToTitle", idToTitle);
        Mockito.verify(mockRequest).setAttribute("messages", fakeMessageList);
        Mockito.verify(mockRequest).setAttribute("idToName", idToName);
        Mockito.verify(mockRequestDispatcher).forward(mockRequest, mockResponse);
    }
    

    
}
