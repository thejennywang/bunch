$(document).ready(function() {

  $('.carousel').carousel({interval: 5000});

  var maxAddresses = 5;
  var northEast = new google.maps.LatLng(51.7422004, 0.310537);
  var southWest = new google.maps.LatLng(51.2415153, -0.5654233);
  londonBounds = new google.maps.LatLngBounds(southWest, northEast);

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

   //initialize first two input boxes with autocomplete
    var addressInput = Mustache.render($('#address_form_template').html(), { index: 1});
    $(addressInput).appendTo('.address-form')
    new google.maps.places.Autocomplete($("#address_1")[0]);

    addressInput = Mustache.render($('#address_form_template').html(), { index: 2});
    $(addressInput).appendTo('.address-form')
    new google.maps.places.Autocomplete($("#address_2")[0]);

    $('.address-form').on('focus', '.form-control', function(event) {
      event.preventDefault();
      var index_value = $('.address').length;
      var isLastAddress = ($('.address').index(this) + 1 == index_value);

      $(this).removeClass('waiting');

      if (index_value < maxAddresses && isLastAddress) {
        var addressInput = Mustache.render($('#address_form_template').html(), { index: index_value + 1});
        $(addressInput).appendTo('.address-form').addClass('waiting').hide().slideDown();
        
        //initialize new input boxes with autocomplete
        var selector = 'input#address_'+ (index_value +1);
        autocompleteArray << new google.maps.places.Autocomplete($(selector)[0]);
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
      region: "UK",
      bounds: londonBounds,
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
      if (londonBounds.contains(latlng)) {
        populateHiddenFields(results[0], index);
      } else {
        $('#js-flash div').remove();
        $('#js-flash').prepend("<div class='alert alert-danger' role='alert'>Addresses must be in London!</div>"); 
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
