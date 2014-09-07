$(document).ready( function () {

  if( $('#venue-container').length ) {
    var venuesURL = document.URL + '/venues?options=topPicks'
    
    displayVenuesFrom(venuesURL);
    $('.find-venues').on('click', function(event) {
      $('#venue-container').empty();
      event.preventDefault();
      displayVenuesFrom(this.href);

    });

    function displayVenuesFrom(url) {
      $.get(url, function(data) {
        data.venues.forEach( function(rawVenue) {
          var venue = new VenueModel(rawVenue);
          var venueCard = Mustache.render($('#venue-template').html(), venue);
          $('#venue-container').append(venueCard);
        });
      });
    };

  };
});

