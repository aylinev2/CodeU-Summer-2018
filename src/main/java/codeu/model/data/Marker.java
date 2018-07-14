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
public class Marker {
  
  private final UUID conversationId;
  private final UUID id;
  private String locationName;
  private double latitude;
  private double longitude;
  private Instant creation;

  /**
   * Constructs a new Marker.
   */
  public Marker(UUID conversationId, UUID id, String locationName, double latitude, double longitude, Instant creation) {
    this.conversationId = conversationId;
    this.id = id;
    this.locationName = locationName;
    this.latitude = latitude;
    this.longitude = longitude;
    this.creation = creation;
  }

  /** Returns the id of the conversation going on at this Marker. */
  public UUID getConversationId() {
    return conversationId;
  }

  /** Returns the ID of this Marker. */
  public UUID getId() {
    return id;
  }

  /** Returns the location name of this Marker. */
  public String getLocationName() {
    return locationName;
  }

  /** Returns the longitude of this Marker. */
  public double getLongitude() {
    return longitude;
  }

  /** Returns the latitude of this Marker. */
  public double getLatitude() {
    return latitude;
  }

  /** Returns the creation time of this Marker. */
  public Instant getCreationTime() {
    return creation;
  }
}

