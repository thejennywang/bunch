$(document).ready( function () {
  var venuesURL = document.URL + '/venues?options=topPicks'
  
  displayVenuesFrom(venuesURL);
  
  $('.find-venues').on('click', function(event) {
    event.preventDefault();
    displayVenuesFrom(this.href);

  });

  function displayVenuesFrom(url) {
    $('#venue-container').empty();
    $.get(url, function(data) {
      data.venues.forEach( function(rawVenue) {
        var venue = new VenueModel(rawVenue);
        var venueCard = Mustache.render($('#venue-template').html(), venue);
        $('#venue-container').append(venueCard);
      });
    });
  };
  
});

