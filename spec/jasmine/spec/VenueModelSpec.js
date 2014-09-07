describe('VenueModel:', function() {
  
  var venue;

  beforeEach(function() {
    venue = new VenueModel();
  });

  describe('defaults', function() {

    it('should have a default name of Unknown', function() {
      expect(venue.name).toEqual('Unknown');
    });
  
    it('should have a default address of Unknown', function() {
      expect(venue.fullAddress).toEqual('Unknown');
    });

    it('should have a default lat of 0.0', function() {
      expect(venue.lat).toEqual(0.0);
    });

    it('should have a default lng of 0.0', function() {
      expect(venue.lng).toEqual(0.0);
    });

    it('should have a default price tier of N/A', function() {
      expect(venue.priceTier).toEqual('N/A');
    });

    it('should have a default rating of N/A', function() {
      expect(venue.rating).toEqual('N/A');
    });

    it('should have a default category of N/A', function() {
      expect(venue.category).toEqual('N/A');
    });

    it('should have a default id of N/A', function() {
      expect(venue.id).toEqual('N/A');
    });

 });

});