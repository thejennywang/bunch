function AddressModel() {
  this.fullAddress = "London, UK";
  this.lat = 51.5286416;
  this.lng = -0.1015986;
};

AddressModel.prototype.populate = function(results) {
  this.fullAddress = results.formatted_address;
  this.lat = results.geometry.location.lat();
  this.lng = results.geometry.location.lng();  
};