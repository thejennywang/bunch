$(document).ready( function () {

  if( $('#venue-container').length ) {
    var venuesURL = document.URL + '/venues?options=topPicks'
    var venueMarkers = [];

    displayVenuesFrom(venuesURL);

    $('#categoryTab a').on('click', function(event) {
      event.preventDefault();
      $(this).parent().addClass("active");
      $(this).parent().siblings().removeClass("active");
      clearMarkers(venueMarkers);
      refreshVenuesWith(this.href);
    });

    function displayVenuesFrom(url) {  
      $.get(url, function(data) {
        data.venues.forEach( function(rawVenue) {
          var venue = new VenueModel(rawVenue);
          addVenueMarker(venue);
          var venueCard = Mustache.render($('#venue-template').html(), venue);
          $(venueCard).appendTo('#venue-container').slideDown(200);
        });
      });
    };

    function refreshVenuesWith(url) {
      $('#venue-container').children().slideUp(200, function() {
        $(this).remove().show()  ;
      });
      displayVenuesFrom(url);
    };

    function addVenueMarker(venue) {
      var marker = mainMap.createMarker({
        lat: venue.lat,
        lng: venue.lng,
        icon: venue.icon,
        infoWindow: {
          content: "<div class='map-infowindow'><h5>"+venue.name+"</h5><p>"+venue.fullAddress[0]+"</p><p>"+venue.fullAddress[3]+"</p>"
        }
      });
      venueMarkers.push(marker);
      mainMap.addMarker(marker);
    };

    function clearMarkers(venueMarkers) {
      venueMarkers.forEach( function(venueMarker) {
        venueMarker.setMap(null);
      })
      venueMarkers = [];
    }

  };
});


