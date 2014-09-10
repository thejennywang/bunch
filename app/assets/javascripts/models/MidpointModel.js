
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
    bounds = bounds.concat(this.zoomInBounds());
    return bounds
};


MidpointModel.prototype.drawCircle = function(map) {
      map.drawCircle ({
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

MidpointModel.prototype.redrawCircle = function(newRadius,map) {
  if (midpoint.radius != newRadius) {
    this.removeCircle(map);
    midpoint.radius = newRadius;
    midpoint.drawCircle(mainMap);
  }
};

MidpointModel.prototype.removeCircle = function(map) {

  if(map.polygons.length > 0) {
    map.polygons[0].setVisible(false)
    map.polygons = [];
  }
};


