$(document).ready( function () {

  $.get(this.href, function(venues) {
      venues.forEach( function(venue) {
        var venueInfo = Mustache.render()
      })
    });

	$('.find-venues').on('click', function(event) {
    event.preventDefault();

		$.get(this.href, function(data) {
			console.log(data);
		});
  });
});