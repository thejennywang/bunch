var northEast = new google.maps.LatLng(51.7422004, 0.310537);
var southWest = new google.maps.LatLng(51.2415153, -0.5654233);
londonBounds = new google.maps.LatLngBounds(southWest, northEast);

$(document).ready(function() {
  $('.new_midpoint').on('submit', function(event) {
    event.preventDefault();
    var path = this.href;

    $('.address').each(function(){
      GMaps.geocode({
        address: $(this).val(),
        region: "UK",
        bounds: londonBounds,
        callback: function(results, status) {
          if (status == 'OK') {
            latlng = results[0].geometry.location;
            if (!londonBounds.contains(latlng)) {
              alert("Please enter an address in London")
            }
          }
          else {
            console.log("address error")
          }
        }
      })
    })

    $.post(this.action, $(this).serialize(), function() {

    })

  })
})