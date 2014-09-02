$(document).ready(function() {

  var northEast = new google.maps.LatLng(51.7422004, 0.310537);
  var southWest = new google.maps.LatLng(51.2415153, -0.5654233);
  londonBounds = new google.maps.LatLngBounds(southWest, northEast);

  $('.bunch-submit').on('click', function(event) {
    event.preventDefault();

    $('.address').each(function(index){
      appendGeocodeInfo($(this).val(), index);
    });

  });

  function appendGeocodeInfo(addressString, index) {
    GMaps.geocode({
      address: addressString,
      region: "UK",
      bounds: londonBounds,
      callback: function(results, status) {
        validateGeocodeInfo(results, status, index);
      }
    });
  };

  function validateGeocodeInfo(results, status, index) {
    if (status == 'OK') {
      latlng = results[0].geometry.location;
      if (londonBounds.contains(latlng)) {
        populateHiddenFields(results[0], index);
      } else {
        alert("Please enter an address in London");
      };
    };
  };

  function populateHiddenFields(result, index) {
    addressModel = new AddressModel();
    addressModel.populate(result);
    $('#full_address_1').val(addressModel.fullAddress);
    if(index === $('.address').length - 1) { $('.new_midpoint').submit(); };
  };

});







