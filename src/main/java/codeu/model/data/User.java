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

package codeu.model.data;

import java.time.Instant;
import java.util.UUID;

/** Class representing a registered user. */
public class User implements Comparable<User>{
  private final UUID id;
  private final String name;
  private String aboutMe;
  private final String passwordHash;
  private final Instant creation;
  private String pictureURL;

  /**
   * Constructs a new User.
   *
   * @param id the ID of this User
   * @param name the username of this User
   * @param passwordHash the password hash of this User
   * @param creation the creation time of this User
   */
  public User(UUID id, String name, String aboutMe, String passwordHash, Instant creation, String pictureURL) {
    this.id = id;
    this.name = name;
    this.aboutMe = aboutMe;
    this.passwordHash = passwordHash;
    this.creation = creation;
    this.pictureURL = pictureURL;
  }

  /** Returns the ID of this User. */
  public UUID getId() {
    return id;
  }

  /** Returns the username of this User. */
  public String getName() {
    return name;
  }

  /** Returns the User's about me statement. */
  public String getAboutMe() {
    return aboutMe;
  }

  /** Changes the User's about me statement. */
  public void setAboutMe(String newAboutMe) {
    aboutMe = newAboutMe;
  }
    
  /** Changes the User's about me statement. */
  public void setProfilePic(String picURL) {
    pictureURL = picURL;
  }


  /** Returns the password hash of this User. */
  public String getPasswordHash() {
    return passwordHash;
  }

  /** Returns the creation time of this User. */
  public Instant getCreationTime() {
    return creation;
  }
    
  public String getPic(){
    return pictureURL;
  }

  @Override
  public int compareTo(User otherUser) {
    if(otherUser == null)
       throw new NullPointerException("Object being compared is null");
    else if(getCreationTime().equals(otherUser.getCreationTime()))
        // user names are unique
       return getName().compareTo(otherUser.getName());
    else
       return getCreationTime().compareTo(otherUser.getCreationTime());
  }
}
