package codeu.model.store.persistence;

import codeu.model.data.Conversation;
import codeu.model.data.Message;
import codeu.model.data.User;
import codeu.model.data.Marker;
import com.google.appengine.tools.development.testing.LocalDatastoreServiceTestConfig;
import com.google.appengine.tools.development.testing.LocalServiceTestHelper;
import java.time.Instant;
import java.util.List;
import java.util.ArrayList;
import java.util.UUID;
import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

/**
 * Test class for PersistentDataStore. The PersistentDataStore class relies on DatastoreService,
 * which in turn relies on being deployed in an AppEngine context. Since this test doesn't run in
 * AppEngine, we use LocalServiceTestHelper to do all of the AppEngine setup so we can test. More
 * info: https://cloud.google.com/appengine/docs/standard/java/tools/localunittesting
 */
public class PersistentDataStoreTest {

  private PersistentDataStore persistentDataStore;
  private final LocalServiceTestHelper appEngineTestHelper =
      new LocalServiceTestHelper(new LocalDatastoreServiceTestConfig());

  @Before
  public void setup() {
    appEngineTestHelper.setUp();
    persistentDataStore = new PersistentDataStore();
  }

  @After
  public void tearDown() {
    appEngineTestHelper.tearDown();
  }

  @Test
  public void testSaveAndLoadUsers() throws PersistentDataStoreException {
    UUID idOne = UUID.fromString("10000000-2222-3333-4444-555555555555");
    String nameOne = "test_username_one";
    String aboutMeOne = "test_aboutMe_one";
    String passwordHashOne = "$2a$10$BNte6sC.qoL4AVjO3Rk8ouY6uFaMnsW8B9NjtHWaDNe8GlQRPRT1S";
    String picOne = "/About-IMG/Default-Profile-IMG.png";
    Instant creationOne = Instant.ofEpochMilli(1000);
    User inputUserOne = new User(idOne, nameOne, aboutMeOne, passwordHashOne, creationOne, picOne);

    UUID idTwo = UUID.fromString("10000001-2222-3333-4444-555555555555");
    String nameTwo = "test_username_two";
    String aboutMeTwo = "test_aboutMe_two";
    String passwordHashTwo = "$2a$10$ttaMOMMGLKxBBuTN06VPvu.jVKif.IczxZcXfLcqEcFi1lq.sLb6i";
    Instant creationTwo = Instant.ofEpochMilli(2000);
    String picTwo = "/About-IMG/Default-Profile-IMG.png";
    User inputUserTwo = new User(idTwo, nameTwo, aboutMeTwo, passwordHashTwo, creationTwo, picTwo);
    // save
    persistentDataStore.writeThrough(inputUserOne);
    persistentDataStore.writeThrough(inputUserTwo);

    // load
    List<User> resultUsers = persistentDataStore.loadUsers();

    // confirm that what we saved matches what we loaded
    User resultUserOne = resultUsers.get(0);
    Assert.assertEquals(idOne, resultUserOne.getId());
    Assert.assertEquals(nameOne, resultUserOne.getName());
    Assert.assertEquals(aboutMeOne, resultUserOne.getAboutMe());
    Assert.assertEquals(passwordHashOne, resultUserOne.getPasswordHash());
    Assert.assertEquals(creationOne, resultUserOne.getCreationTime());
    Assert.assertEquals(picOne, resultUserOne.getPic());

    User resultUserTwo = resultUsers.get(1);
    Assert.assertEquals(idTwo, resultUserTwo.getId());
    Assert.assertEquals(nameTwo, resultUserTwo.getName());
    Assert.assertEquals(aboutMeTwo, resultUserTwo.getAboutMe());
    Assert.assertEquals(passwordHashTwo, resultUserTwo.getPasswordHash());
    Assert.assertEquals(creationTwo, resultUserTwo.getCreationTime());
    Assert.assertEquals(picTwo, resultUserTwo.getPic());
  }

  @Test
  public void testSaveAndLoadConversations() throws PersistentDataStoreException {
    UUID idOne = UUID.fromString("10000000-2222-3333-4444-555555555555");
    UUID ownerOne = UUID.fromString("10000001-2222-3333-4444-555555555555");
    String titleOne = "Test_Title";
    Instant creationOne = Instant.ofEpochMilli(1000);
    Conversation inputConversationOne = new Conversation(idOne, ownerOne, titleOne, creationOne);

    UUID idTwo = UUID.fromString("10000002-2222-3333-4444-555555555555");
    UUID ownerTwo = UUID.fromString("10000003-2222-3333-4444-555555555555");
    String titleTwo = "Test_Title_Two";
    Instant creationTwo = Instant.ofEpochMilli(2000);
    Conversation inputConversationTwo = new Conversation(idTwo, ownerTwo, titleTwo, creationTwo);

    // save
    persistentDataStore.writeThrough(inputConversationOne);
    persistentDataStore.writeThrough(inputConversationTwo);

    // load
    List<Conversation> resultConversations = persistentDataStore.loadConversations();

    // confirm that what we saved matches what we loaded
    Conversation resultConversationOne = resultConversations.get(0);
    Assert.assertEquals(idOne, resultConversationOne.getId());
    Assert.assertEquals(ownerOne, resultConversationOne.getOwnerId());
    Assert.assertEquals(titleOne, resultConversationOne.getTitle());
    Assert.assertEquals(creationOne, resultConversationOne.getCreationTime());

    Conversation resultConversationTwo = resultConversations.get(1);
    Assert.assertEquals(idTwo, resultConversationTwo.getId());
    Assert.assertEquals(ownerTwo, resultConversationTwo.getOwnerId());
    Assert.assertEquals(titleTwo, resultConversationTwo.getTitle());
    Assert.assertEquals(creationTwo, resultConversationTwo.getCreationTime());
  }

  @Test
  public void testSaveAndLoadMessages() throws PersistentDataStoreException {
    UUID idOne = UUID.fromString("10000000-2222-3333-4444-555555555555");
    UUID conversationOne = UUID.fromString("10000001-2222-3333-4444-555555555555");
    UUID authorOne = UUID.fromString("10000002-2222-3333-4444-555555555555");
    UUID parentMsgOne = UUID.fromString("10000006-2222-3333-4444-555555555555");
    String contentOne = "test content one";
    Instant creationOne = Instant.ofEpochMilli(1000);
    Message inputMessageOne =
        new Message(idOne, conversationOne, authorOne, contentOne, creationOne, parentMsgOne);

    UUID idTwo = UUID.fromString("10000003-2222-3333-4444-555555555555");
    UUID conversationTwo = UUID.fromString("10000004-2222-3333-4444-555555555555");
    UUID authorTwo = UUID.fromString("10000005-2222-3333-4444-555555555555");
    UUID parentMsgTwo = UUID.fromString("10000007-2222-3333-4444-555555555555");
    String contentTwo = "test content one";
    Instant creationTwo = Instant.ofEpochMilli(2000);
    Message inputMessageTwo =
        new Message(idTwo, conversationTwo, authorTwo, contentTwo, creationTwo, parentMsgTwo);

    // save
    persistentDataStore.writeThrough(inputMessageOne);
    persistentDataStore.writeThrough(inputMessageTwo);

    // load
    List<Message> resultMessages = persistentDataStore.loadMessages();

    // confirm that what we saved matches what we loaded
    Message resultMessageOne = resultMessages.get(0);
    Assert.assertEquals(idOne, resultMessageOne.getId());
    Assert.assertEquals(conversationOne, resultMessageOne.getConversationId());
    Assert.assertEquals(authorOne, resultMessageOne.getAuthorId());
    Assert.assertEquals(contentOne, resultMessageOne.getContent());
    Assert.assertEquals(creationOne, resultMessageOne.getCreationTime());
    Assert.assertEquals(parentMsgOne, resultMessageOne.getParentMessageId());

    Message resultMessageTwo = resultMessages.get(1);
    Assert.assertEquals(idTwo, resultMessageTwo.getId());
    Assert.assertEquals(conversationTwo, resultMessageTwo.getConversationId());
    Assert.assertEquals(authorTwo, resultMessageTwo.getAuthorId());
    Assert.assertEquals(contentTwo, resultMessageTwo.getContent());
    Assert.assertEquals(creationTwo, resultMessageTwo.getCreationTime());
    Assert.assertEquals(parentMsgTwo, resultMessageTwo.getParentMessageId());
  }
    
    @Test
    public void testSaveAndLoadMarkers() throws PersistentDataStoreException {
        
        // Create a message
        UUID idTwo = UUID.fromString("10000003-2222-3333-4444-555555555555");
        UUID conversationTwo = UUID.fromString("10000004-2222-3333-4444-555555555555");
        UUID authorTwo = UUID.fromString("10000005-2222-3333-4444-555555555555");
        UUID parentMsgTwo = UUID.fromString("10000007-2222-3333-4444-555555555555");
        String contentTwo = "test content one";
        Instant creationTwo = Instant.ofEpochMilli(2000);
        Message inputMessageTwo =
        new Message(idTwo, conversationTwo, authorTwo, contentTwo, creationTwo, parentMsgTwo);
        
        UUID idOne = UUID.fromString("10000000-2222-3333-4444-555555555555");
        UUID convoIdOne = UUID.fromString("10000000-4222-3333-4444-555555555555");
        String name = "example place";
        double lat = 4.7909090;
        double lng = -5.020392039;
        Instant creationOne = Instant.ofEpochMilli(1000);
        Marker inputMarkerOne =
        new Marker(convoIdOne, idOne, name, lat, lng, creationOne);
        // save
        persistentDataStore.writeThrough(inputMarkerOne);
        
        // load
        List<Marker> resultMarkers = persistentDataStore.loadMarkers();
        
        // confirm that what we saved matches what we loaded
        Marker resultMarkerOne = resultMarkers.get(0);
        Assert.assertEquals(idOne, resultMarkerOne.getId());
        Assert.assertEquals(convoIdOne, resultMarkerOne.getConversationId());
        Assert.assertEquals(name, resultMarkerOne.getLocationName());
        Assert.assertEquals(lat, resultMarkerOne.getLatitude(), 0.0);
        Assert.assertEquals(lng, resultMarkerOne.getLongitude(), 0.0);
        Assert.assertEquals(creationOne, resultMarkerOne.getCreationTime());
    }
}
