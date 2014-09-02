$(document).ready(function() {
  var northEast = new google.maps.LatLng(51.7422004, 0.310537);
  var southWest = new google.maps.LatLng(51.2415153, -0.5654233);
  londonBounds = new google.maps.LatLngBounds(southWest, northEast);

  $('.new_midpoint').on('submit', function(event) {
    event.preventDefault();
    geocodedAddresses = [];

    $('.address').each(function(){
      geocodeAddress($(this).val());
    });

    $.post(this.action, $(this).serialize(), function() {});
  });

});


function geocodeAddress(addressString) {
  GMaps.geocode({
    address: addressString,
    region: "UK",
    bounds: londonBounds,
    callback: function(results, status) {
      if (status == 'OK') {
        latlng = results[0].geometry.location;
        if (londonBounds.contains(latlng)) {
          populateAddressArray(results[0]);
        } else {
          alert("Please enter an address in London");
        }
      }
    }
  });
}

function populateAddressArray(result) {
  addressModel = new AddressModel();
  addressModel.populate(result);
  geocodedAddresses.push(addressModel);
  console.log(geocodedAddresses);
}