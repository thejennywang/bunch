$(document).ready( function () {
  var venuesURL = document.URL + '/venues?options=food'
  $.get(venuesURL, function(data) {
    data.venues.forEach( function(rawVenue) {
      var venue = new VenueModel(rawVenue);
      var venueCard = Mustache.render($('#venue-template').html(), venue);
      $('#venue-container').append(venueCard);
    });
  });
	


  $('.find-venues').on('click', function(event) {
    event.preventDefault();

		$.get(this.href, function(data) {
      data.venues.forEach( function(rawVenue) {
        var venue = new VenueModel(rawVenue);
        var venueCard = Mustache.render($('#venue-template').html(), venue);
        $('#venue-container').append(venueCard);
      });
		});
  });
});