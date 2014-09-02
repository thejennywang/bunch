var northEast = new google.maps.LatLng(51.7422004, 0.310537);
var southWest = new google.maps.LatLng(51.2415153, -0.5654233);
londonBounds = new google.maps.LatLngBounds(southWest, northEast);

$(document).ready(function() {
  $('.bunch-submit').on('click', function(event) {
    event.preventDefault();

    $('.address').each(function(){
      GMaps.geocode({
        address: $(this).val(),
        region: "UK",
        bounds: londonBounds,
        callback: function(results, status) {
          if (status == 'OK') {
            console.log(results)
            var latlng = results[0].geometry.location;
            console.log(latlng)
          }
          else {
            console.log("address error")
          }
        }
      })
    })
  })
})