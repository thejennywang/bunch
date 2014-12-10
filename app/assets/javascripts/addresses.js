$(document).ready(function() {

  $('.carousel').carousel({interval: 5000});

  var maxAddresses = 5;
  var northEast = new google.maps.LatLng(40.92, -73.70);
  var southWest = new google.maps.LatLng(40.47, -74.26);
  nycBounds = new google.maps.LatLngBounds(northEast, southWest);

  $('.bunch-submit').on('click', function(event) {
    event.preventDefault();

    $('#js-flash div').remove();
    var index = 0;

    checkForEmptyAddressFields();

    var promises = $('.address').map(function(){
      index += 1;
      return appendGeocodeInfo($(this).val(), index);
    });

    Q.all(promises).then(function(){ if(noBadAddresses()) submitForm(); })
  });

  $('.address-form').on('focus', '.form-control', function(event) {
    event.preventDefault();
    var index_value = $('.address').length;
    var isLastAddress = ($('.address').index(this) + 1 == index_value);

    $(this).removeClass('waiting');

    if (index_value < maxAddresses && isLastAddress) {
      var addressInput = Mustache.render($('#address_form_template').html(), { index: index_value + 1});
      $(addressInput).appendTo('.address-form').addClass('waiting').hide().slideDown();
    };
  });

  function checkForEmptyAddressFields() {
    $('.required-address').each(function(index){
      if($(this).val() === "") {
        $('#js-flash div').remove();
        $('#js-flash').prepend("<div class='alert alert-danger' role='alert'>Please enter at least two addresses!</div>"); 
      };
    });
  };

  function appendGeocodeInfo(addressString, index) {
    var deferred = Q.defer();

    GMaps.geocode({
      address: addressString,
      region: "US",
      bounds: nycBounds,
      callback: function(results, status) {
        validateGeocodeInfo(results, status, index);
        deferred.resolve(true);
      }
    });
    return deferred.promise;
  };

  function validateGeocodeInfo(results, status, index) {
    if (status == 'OK') {
      latlng = results[0].geometry.location;
      if (nycBounds.contains(latlng)) {
        populateHiddenFields(results[0], index);
      } else {
        $('#js-flash div').remove();
        $('#js-flash').prepend("<div class='alert alert-danger' role='alert'>Addresses must be in NYC!</div>"); 
      };
    } else {
      $('#js-flash div').remove();
      $('#js-flash').prepend("<div class='alert alert-danger' role='alert'>Not a valid address</div>"); 
    };
  };

  function populateHiddenFields(result, index) {
    addressModel = new AddressModel();
    addressModel.populate(result);

    $('#full_address_' + index.toString()).val(addressModel.fullAddress);
    $('#lat_' + index.toString()).val(addressModel.lat);
    $('#lng_' + index.toString()).val(addressModel.lng);
  };

  function isFinalAddress(i) {
    return (i + 1 === 5);
  };

  function noBadAddresses() {
    return ($('#js-flash div').length === 0);
  };

  function submitForm() {
    $('.new_midpoint').submit();
  };

});
