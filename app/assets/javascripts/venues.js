$(document).ready( function () {

  if( $('#venue-container').length ) {
    var venuesURL = document.URL + '/venues?options=topPicks'
    
    displayVenuesFrom(venuesURL);

    $('#categoryTab a').on('click', function(event) {
      event.preventDefault();
      displayVenuesFrom(this.href);
      $(this).parent().addClass("active");
      $(this).parent().siblings().removeClass("active");
    })

    function displayVenuesFrom(url) {
      $('#venue-container').children().slideUp(200, function() {
          $(this).remove().show()  ;
        });
      
      $.get(url, function(data) {
        data.venues.forEach( function(rawVenue) {
          var venue = new VenueModel(rawVenue);
          var venueCard = Mustache.render($('#venue-template').html(), venue);
          $(venueCard).appendTo('#venue-container').slideDown(200);

        });
      });
    };

  };
});


