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

package codeu.model.store.basic;

import codeu.model.data.Marker;
import codeu.model.store.persistence.PersistentStorageAgent;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * Store class that uses in-memory data structures to hold values and automatically loads from and
 * saves to PersistentStorageAgent. It's a singleton so all servlet classes can access the same
 * instance.
 */
public class MarkerStore {

  /** Singleton instance of MarkerStore. */
  private static MarkerStore instance;

  /**
   * Returns the singleton instance of MarkerStore that should be shared between all servlet classes.
   * Do not call this function from a test; use getTestInstance() instead.
   */
  public static MarkerStore getInstance() {
    if (instance == null) {
      instance = new MarkerStore(PersistentStorageAgent.getInstance());
    }
    return instance;
  }

  /**
   * Instance getter function used for testing. Supply a mock for PersistentStorageAgent.
   *
   * @param persistentStorageAgent a mock used for testing
   */
  public static MarkerStore getTestInstance(PersistentStorageAgent persistentStorageAgent) {
    return new MarkerStore(persistentStorageAgent);
  }

  /**
   * The PersistentStorageAgent responsible for loading Markers from and saving Markers to Datastore.
   */
  private PersistentStorageAgent persistentStorageAgent;

  /** The in-memory list of markers. */
  private List<Marker> markers;

  /** This class is a singleton, so its constructor is private. Call getInstance() instead. */
  private MarkerStore(PersistentStorageAgent persistentStorageAgent) {
    this.persistentStorageAgent = persistentStorageAgent;
    markers = new ArrayList<>();
  }
    
  /** Access the current set of markers known to the application. */
  public List<Marker> getAllMarkers() {
    return markers;
  }

  /** Check whether a Marker location name is already known to the application. */
  public boolean isNameTaken(String name) {
    // This approach will be pretty slow if we have many Markers.
    for (Marker marker : markers) {
      if (marker.getLocationName().equals(name)) {
        return true;
      }
    }
    return false;
  }

  /**
   * Access the marker object with the given UUID.
   *
   * @return null if the UUID does not match any existing marker.
   */
  public Marker getMarker(UUID id) {
    for (Marker marker : markers) {
      if (marker.getId().equals(id)) {
        return marker;
      }
    }
    return null;
  }

  /**
   * Access the marker object with the given conversation UUID.
   *
   * @return null if the conversation UUID does not match any existing marker.
   */
  public Marker getMarkerByConvo(UUID convoId) {
    for (Marker marker : markers) {
      if (marker.getConversationId().equals(convoId)) {
        return marker;
      }
    }
    return null;
  }

  /**
   * Add a new user to the current set of users known to the application. This should only be called
   * to add a new user, not to update an existing user.
   */
  public void addMarker(Marker marker) {
    markers.add(marker);
    persistentStorageAgent.writeThrough(marker);
  }

  /**
   * Update an existing marker.
   */
  public void updateMarker(Marker marker) {
    persistentStorageAgent.writeThrough(marker);
  }

  /**
   * Sets the List of Markers stored by this MarkerStore. This should only be called once, when the data
   * is loaded from Datastore.
   */
  public void setMarkers(List<Marker> markers) {
    this.markers = markers;
  }
}

