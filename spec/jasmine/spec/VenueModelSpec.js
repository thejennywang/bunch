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
    "id": "4ac518c5f964a520e2a420e3",
    "icon": "https://ss1.4sqi.net/img/categories_v2/food/gastropub_bg_44.png"
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

    it('should have an icon url', function() {
      expect(venue.icon).toEqual('https://ss1.4sqi.net/img/categories_v2/food/gastropub_bg_44.png');
    });

 });

  describe('#formattedAddress', function() {

    it('should return a formatted address', function() {
      expect(venue.formattedAddress()).toEqual("16 Elia St (at Quick St), N1 8DE");
    });

  });

  describe('#formattedPriceTier', function () {

    it('should return N/A if the price tier is not a number', function() {
      venue.priceTier = 'error';
      expect(venue.formattedPriceTier()).toEqual('N/A');
    });

    it('should return £ if the price tier is 1', function() {
      venue.priceTier = 1;
      expect(venue.formattedPriceTier()).toEqual('£');
    });

    it('should return ££££ if the price tier is 4', function() {
      venue.priceTier = 4;
      expect(venue.formattedPriceTier()).toEqual('££££');
    });

  });

  describe('#starRating', function() {

    it('should return N/A is the rating is not a number', function() {
      venue.rating = 'error';
      expect(venue.starRating()).toEqual('N/A');
    });

    it('should return ★★★★★ if the rating is 10', function() {
      venue.rating = 10.0;
      expect(venue.starRating()).toEqual('★★★★★');
    });

    it('should return ★★★☆☆ for a star rating of 6.5', function () {
      venue.rating = 6.5;
      expect(venue.starRating()).toEqual('★★★☆☆');
    });

  });

  describe('#detailUrl', function() {
    
    it('should return a valid foursquare venue url given venue id', function() {
      expect(venue.detailUrl()).toEqual("https://foursquare.com/v/4ac518c5f964a520e2a420e3");
    });
  
  });

});