describe('VenueModel:', function() {
  
  var venue;
  var venueData = {
    "name": "The Charles Lamb",
    "fullAddress": [
    "16 Elia St (at Quick St)",
    "Islington",
    "Greater London",
    "N1 8DE",
    "United Kingdom"
    ],
    "lat": 51.5319382,
    "lng": -0.1020542,
    "category": "Wine Bar",
    "priceTier": 2,
    "rating": 8.9,
    "id": "4ac518c5f964a520e2a420e3"
  };

  beforeEach(function() {
    venue = new VenueModel(venueData);
  });

  describe('initialization', function() {

    it('should have a name', function() {
      expect(venue.name).toEqual('The Charles Lamb');
    });
  
    it('should have an address', function() {
      expect(venue.fullAddress).toContain('16 Elia St (at Quick St)');
    });

    it('should have a lat', function() {
      expect(venue.lat).toEqual(51.5319382);
    });

    it('should have a lng', function() {
      expect(venue.lng).toEqual(-0.1020542);
    });

    it('should have a priceTier', function() {
      expect(venue.priceTier).toEqual(2);
    });

    it('should have a rating', function() {
      expect(venue.rating).toEqual(8.9);
    });

    it('should have a category', function() {
      expect(venue.category).toEqual('Wine Bar');
    });

    it('should have an id', function() {
      expect(venue.id).toEqual('4ac518c5f964a520e2a420e3');
    });

 });

  describe('#formattedAddress', function() {

    it('should return a formatted address', function() {
      expect(venue.formattedAddress()).toEqual("16 Elia St (at Quick St), Islington, N1 8DE");
    });

  });

});