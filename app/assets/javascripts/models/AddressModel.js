function AddressModel() {
  this.fullAddress = "xyz";
  this.lat = 0;
  this.lng = 0;
};

AddressModel.prototype.populate = function(results) {
  this.fullAddress = results.formatted_address;
  this.lat = results.geometry.location.lat();
  this.lng = results.geometry.location.lng();  
};