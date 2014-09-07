function VenueModel(venueData) {
  this.name = venueData.name;
  this.fullAddress = venueData.fullAddress;
  this.lat = venueData.lat;
  this.lng = venueData.lng;
  this.priceTier = venueData.priceTier;
  this.rating = venueData.rating;
  this.category = venueData.category;
  this.id = venueData.id;
};

VenueModel.prototype.formattedAddress = function() {
  return this.fullAddress[0] + ', '
              + this.fullAddress[3];
};

