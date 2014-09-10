
function createLatLong(geolocation){
  return new google.maps.LatLng(geolocation.lat,geolocation.lng)
}

var metresToDegConverter = 100000; 

function MidpointModel(data) {
  this.lat = data.midpoint.lat;
  this.lng = data.midpoint.lng;
  this.addresses = data.address;
  this.radius = 250;
};

MidpointModel.prototype.zoomInBounds = function() {
  var max_north = new google.maps.LatLng(this.lat  + this.radius/metresToDegConverter, this.lng)
  var max_south = new google.maps.LatLng(this.lat  - this.radius/metresToDegConverter, this.lng)
  var max_east = new google.maps.LatLng(this.lat, this.lng + this.radius/metresToDegConverter)
  var max_west = new google.maps.LatLng(this.lat, this.lng - this.radius/metresToDegConverter)
  console.log(this)
  return [max_north,max_south,max_west,max_east]
  };

MidpointModel.prototype.createDummyLatLong = function() {
  var westLngs = this.addresses.map(function(address){ return address.lng })
  var addressMinLng = Math.min.apply(null, westLngs);
  var distance = this.lng-addressMinLng;
  return new google.maps.LatLng(this.lat,addressMinLng-distance/2)
};


MidpointModel.prototype.zoomOutBounds = function() {
    var bounds = this.addresses.map(function(address){ return createLatLong(address) }) 
    bounds.push(this.createDummyLatLong())
    bounds.push(new google.maps.LatLng(this.lat,this.lng))
    return bounds
};

MidpointModel.prototype.drawCircle = function(map) {
      circle = map.drawCircle ({
        lat: this.lat,
        lng: this.lng,
        radius: this.radius,
        fillColor: "red",
        fillOpacity: 0.5,
        strokeColor: "#99cc33",
        strokeOpacity: 0,
        strokeWeight: 0
    });
};

