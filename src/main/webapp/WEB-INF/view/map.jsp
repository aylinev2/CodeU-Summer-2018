<%@ page import= "java.util.UUID" %>
<%@ page import="codeu.model.data.Marker" %>
<%@ page import="codeu.model.data.Conversation" %>
<%@ page import="codeu.model.store.basic.ConversationStore" %>
<%@ page import="com.vdurmont.emoji.EmojiParser" %>
<%@ page import="java.util.List" %>


<!DOCTYPE html>
<html>
  <head>
  <meta charset="utf-8">
  <title>Map</title>
  <link rel="stylesheet" href="/css/main.css">
  </head>
  <body>
    <%@ include file="/WEB-INF/view/navbar.jsp" %>  
  <div id="container2">
    <h1>The Map</h1>
    <ul>
    <li>To join a conversation that has already started at a location, just click on the marker that is there!</li>
    <li>To add a new marker, click on a spot on the map and fill out the location name field to succesfully save your marker and start a new conversation! <p>(Tip: click on the marker that you just created to see its exact coordinates)</p></li>
     
    <% if(request.getAttribute("error") != null){ %>
        <h2 style="color:red"><%= request.getAttribute("error") %></h2>
    <% } 
    if(request.getSession().getAttribute("user") != null){ 
    %>
      <h2>Add a new marker:</h2>
      <form action="/map" method="POST">
        <h3>Location Name:</h3>
        <input id="placeName" type="text" name="locationName">
        <br/><p style="font-size:12px">To use an emoji, write an <a id="ul-link" href="https://www.webpagefx.com/tools/emoji-cheat-sheet/">emoji name</a> between colons (:cat: -> &#x1F431;)</p>
        <h3>Latitude:</h3>
        <input id="latitudeVal" type="text" name="latitudeVal">
        <h3>Longitude:</h3>
        <input id="longitudeVal" type="text" name="longitudeVal">
        <br/><br/>
        <button type="submit">Submit</button>
      </form>
    <% } 
    else { %>
     <a id="ul-link" href="/login">Login</a> or  <a id="ul-link" href="/register">Register</a> to add a marker!
    <% } %>
      </ul>  
      <hr/>
    <!--The search element for the map -->
    <input id="pac-input" class="controls" type="text" placeholder="Search Google Maps">
    <button id= "clearButton" onclick="resetSearch()">Clear</button>
    <!--The div element for the map --> 
    <div id="map"></div>
  </div>
    <script>
      <% if(request.getSession().getAttribute("user") == null) { %>
        document.getElementById("map").style.marginTop = "-355px";
      <% } %>

      var locNames = [];
      var convoNames = [];
      var markerLocs = [];
    <%
    List<Marker> markers = (List<Marker>) request.getAttribute("markers");
    if(markers != null && !markers.isEmpty()) {
       for(Marker marker: markers) {
       %>
           markerLocs.push({lat: <%= marker.getLatitude() %>, lng: <%= marker.getLongitude() %>},);
           locNames.push("<%= EmojiParser.parseToUnicode(marker.getLocationName()) %>",);
          convoNames.push("<%= marker.getLocationName().replaceAll("\\s", "") %>",);
       <%} 
    }%>

  var map;
  var markers = [];

  // Initialize and add the map
  function initMap() {
  // The map, centered in the United States
     map = new google.maps.Map(
      document.getElementById('map'), {
        center: {lat: 38.70748253635325, lng: -9.147507253577942},
        zoom: 2
      });

     var input = document.getElementById('pac-input');
     var clearButton = document.getElementById('clearButton');
     map.controls[google.maps.ControlPosition.TOP_CENTER].push(input);
     map.controls[google.maps.ControlPosition.TOP_CENTER].push(clearButton);

  // This event listener calls addMarker() when the map is clicked.
        google.maps.event.addListener(map, 'click', function(event) {
          addMarker(event.latLng, map);
          document.querySelector("#latitudeVal").value = event.latLng.lat();
          document.querySelector("#longitudeVal").value = event.latLng.lng();
        });

        if(markerLocs != null) {
          for (var i in markerLocs) {
            addMarkerFromStore(markerLocs[i], map, locNames[i], convoNames[i])
          }
        }

      //!--------------------------
      // Code to display search box
      // Create the search box and link it to the UI element.
      var stepDisplay = new google.maps.InfoWindow;
      var searchBox = new google.maps.places.SearchBox(input);
      var locationDisplay = new google.maps.InfoWindow;

      // Bias the SearchBox results towards current map's viewport.
      map.addListener('bounds_changed', function() {
        searchBox.setBounds(map.getBounds());
      });

      // Listen for the event fired when the user selects a prediction and retrieve more details for that place.
      searchBox.addListener('places_changed', function() {
        var places = searchBox.getPlaces();

        if (places.length == 0) {
          return;
        }
        clearMarkers();

        // For each place, get the icon, name and location.
        var bounds = new google.maps.LatLngBounds();
        
        places.forEach(function(place) {
          if (!place.geometry) {
            console.log("Returned place contains no geometry");
            return;
          }
          // Create a marker for each place.
          var lookMarker = new google.maps.Marker({
            map: map,
            title: place.name,
            position: place.geometry.location,
            icon: 'http://maps.google.com/mapfiles/kml/paddle/purple-circle.png'
          });

          markers.push(lookMarker);

          google.maps.event.addListener(lookMarker, 'click', function() {

            stepDisplay.setContent('<b>Name:</b> ' + place.name + '<br><b>Address:</b> ' + place.formatted_address + '<br>'+ place.geometry.location + '<b><br>This marker has not been saved yet! Please fill out the form next to the map to save a marker!</b>');

            document.querySelector("#placeName").value = place.name;
            document.querySelector("#latitudeVal").value = lookMarker.position.lat();
            document.querySelector("#longitudeVal").value = lookMarker.position.lng();
            stepDisplay.open(map, lookMarker);
          });

          if (place.geometry.viewport) {
            // Only geocodes have viewport.
            bounds.union(place.geometry.viewport);
          } else {
            bounds.extend(place.geometry.location);
          }
        });
        map.fitBounds(bounds);
      });

  }

  // Adds a markerstore marker to the map.
      function addMarkerFromStore(location, map, markerName, convoName) {
        var contentString = '<h3 align="center">' + markerName +'</h3>' + '<a id="ul-link" href="/chat/' + convoName 
        +'">Join</a> the conversation going on at this location!';

        var infowindow = new google.maps.InfoWindow({
          content: contentString
        });

        var marker = new google.maps.Marker({
          position: location,
          map: map,
          icon: 'https://maps.google.com/mapfiles/kml/paddle/ltblu-circle.png'
        });

        marker.addListener('click', function() {
          infowindow.open(map, marker);
        });
      }

  // Adds a marker to the map.
      function addMarker(location, map) {
        var contentString = 
            '<b>coordinates: </b> ' + location + '<br><br>This marker has not been saved yet! Please fill out the form next to the map to save a marker!';

        var infowindow = new google.maps.InfoWindow({
          content: contentString
        });

        var marker = new google.maps.Marker({
          position: location,
          map: map,
          icon: 'https://maps.google.com/mapfiles/kml/paddle/pink-circle.png'
        });

        marker.addListener('click', function() {
          infowindow.open(map, marker);
        });
      }

      // Clears markers used for search bar
      function clearMarkers() {
        // Clear out the old search markers.
        markers.forEach(function(marker) {
          marker.setMap(null);
        });
        markers = [];
      }

      // Clears markers AND search bar entry
      function resetSearch() {
        document.querySelector("#pac-input").value = "";
         markers.forEach(function(marker) {
          marker.setMap(null);
        });
        markers = [];
      }

      google.maps.event.addDomListener(window, 'load', initialize);
    </script>
    <!--Load the API from the specified URL
    * The async attribute allows the browser to render the page while the API loads
    * The key parameter will contain your own API key (which is not needed for this tutorial)
    * The callback parameter executes the initMap() function
    -->
     <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB37P8-JjkAgqSEs4M0eHX0vlNRjvTVbzU&libraries=places&callback=initMap"
         async defer></script>
  </body>
</html>

