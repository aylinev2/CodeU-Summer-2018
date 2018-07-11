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
import java.util.List;
import java.util.UUID;
import codeu.model.data.Message;

/** Class representing a registered user. */
public class Marker {
  private String locationName;
  private String locationAddress;
  private String locationId;
  private List<Message> locationReviews;
  private Instant creation;

  /**
   * Constructs a new Marker.
   */
  public Marker(String locationName, String locationAddress, String locationId, Instant creation) {
    this.locationName = locationName;
    this.locationAddress = locationAddress;
    this.locationId = locationId;
    this.creation = creation;
  }

  /** Returns the name of this Marker. */
  public String getLocationName() {
    return locationName;
  }

  /** Returns the location of this Marker. */
  public String getLocationAddress() {
    return locationAddress;
  }

  /** Returns the id hash of this Marker. */
  public String getLocationId() {
    return locationId;
  }

  /** Returns the creation time of this Marker. */
  public Instant getCreationTime() {
    return creation;
  }
    
  public List<Message> getLocationReviews() {
    return locationReviews;
  }
    
  void addReview(Message newReview) {
      locationReviews.add(newReview);
  }

}
