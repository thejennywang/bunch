$(document).ready( function () {

  if( $('#venue-container').length ) {
    var venuesURL = document.URL + '/venues?options='
    var venueMarkers = [];
    var promises = null;


    displayVenuesFrom(venuesURL);
    
    
    $('#categoryTab a').on('click', function(event) {
        event.preventDefault();
        venuesUrl = this.href

        $(this).parent().addClass("active");
        $(this).parent().siblings().removeClass("active");
        
        clearMarkers(venueMarkers);
        Q.all(promises).then(function(){ promises = refreshVenuesWith(venuesUrl) });         
    });

    function displayVenuesFrom(url) { 
      $('#venue-container').append("<img id='venue-spinner' src='/images/ajax-loader.gif'></br><p> Loading...</p>");

      $.get(url, function(data) {
        midpoint.redrawCircle(data.radius,mainMap)
        
        if ($('#map-zoom-in').hasClass("active-zoom-button")) { 
          $('#map-zoom-in').click();
        };

        $('#venue-container').empty();

        promises = data.venues.map( function(rawVenue) {
          return appendVenueToContainer(rawVenue);
        });

      });
    };

    function refreshVenuesWith(url) {
     $('#venue-container').children().slideUp(200, function() {
        $(this).remove().show();    
      });

      return displayVenuesFrom(url);
    };

    function appendVenueToContainer(rawVenue) {
      var venue = new VenueModel(rawVenue);
      var venueCard = Mustache.render($('#venue-template').html(), venue);
      var deferred = Q.defer();

      $(venueCard).appendTo('#venue-container').slideDown(200, function() {
        deferred.resolve(true);
      }); 

      addVenueMarker(venue);

      return deferred.promise;
    };

    function addVenueMarker(venue) {
      var marker = mainMap.createMarker({
        lat: venue.lat,
        lng: venue.lng,
        icon: venue.smallIcon(),
        class: "venue-marker",
        infoWindow: {
          content: "<div class='map-infowindow'><div class='venue-title'>"+venue.name+"</div><div class='venue-rating'>"+venue.starRating()+"</div><div class='venue-address'>"+venue.fullAddress[0]+"</div>"
        }
      });
      venueMarkers.push(marker);
      mainMap.addMarker(marker);
    };

    function clearMarkers(venueMarkers) {
      venueMarkers.forEach( function(venueMarker) {
        venueMarker.setMap(null);
      });
      venueMarkers = [];
    };



  };
});
