<%@ page import= "java.util.UUID" %>
<%@ page import="codeu.model.data.Marker" %>
<%@ page import="codeu.model.data.Conversation" %>
<%@ page import="codeu.model.store.basic.ConversationStore" %>
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
    <li>To add a new marker, log in and click on a spot on the map. Be sure to fill out the location name field to succesfully save your marker and start a new conversation! <p>(Tip: click on the marker that you just created to see its exact coordinates)</p></li>
    </ul>

    <% if(request.getAttribute("error") != null){ %>
        <h2 style="color:red"><%= request.getAttribute("error") %></h2>
    <% } %>
   
      <h2>Add a new marker:</h2>
      <form action="/map" method="POST">
        <h3>Location Name:</h3>
        <input type="text" name="locationName">
        <h3>Latitude:</h3>
        <input id="latitudeVal" type="text" name="latitudeVal">
        <h3>Longitude:</h3>
        <input id="longitudeVal" type="text" name="longitudeVal">
        <br/><br/>
        <button type="submit">Submit</button>
    </form>
      <hr/>
    <!--The div element for the map -->
      <div id="map"></div>
    </div> 

    <script>
      var locNames = [];
      var convoNames = [];
      var markerLocs = [];
    <%
    List<Marker> markers = (List<Marker>) request.getAttribute("markers");
    if(markers != null && !markers.isEmpty()) {
       for(Marker marker: markers) {
       %>
           markerLocs.push({lat: <%= marker.getLatitude() %>, lng: <%= marker.getLongitude() %>},);
           locNames.push("<%= marker.getLocationName() %>",);
          convoNames.push("<%= marker.getLocationName().replaceAll("\\s", "") %>",);
       <%} 
    }%>

  var map;

  // Initialize and add the map
  function initMap() {
  // The map, centered in the United States
     map = new google.maps.Map(
      document.getElementById('map'), {
        center: {lat: 41.881832, lng: -87.623177},
        zoom: 4
      });

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
  }

  // Adds a markerstore marker to the map.
      function addMarkerFromStore(location, map, markerName, convoName) {
        var contentString = '<h3 align="center">' + markerName +'</h3>' + '<a href="/chat/' + convoName 
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

      google.maps.event.addDomListener(window, 'load', initialize);
      </script>
    <!--Load the API from the specified URL
    * The async attribute allows the browser to render the page while the API loads
    * The key parameter will contain your own API key (which is not needed for this tutorial)
    * The callback parameter executes the initMap() function
    -->
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB37P8-JjkAgqSEs4M0eHX0vlNRjvTVbzU&callback=initMap">
    </script>
  </body>
</html>

