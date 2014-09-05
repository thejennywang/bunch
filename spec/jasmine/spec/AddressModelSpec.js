describe('AddressModel:', function() {
  
  var address;
  var gmapResult;
  var latlng;

  beforeEach(function() {
    address = new AddressModel();
  });

  describe('defaults', function() {
  
    it('should have a default address of Unknown', function() {
      expect(address.fullAddress).toEqual('Unknown');
    });

    it('should have a default latitude of 0', function() {
      expect(address.lat).toEqual(0);
    });

   it('should have a default longitude of 0', function() {
     expect(address.lng).toEqual(0);
   });

 });

  describe('#populate', function() {

    beforeEach(function() {
      latlng = jasmine.createSpyObj('latlng', ['lat', 'lng']);
      gmapResult = { formatted_address : 'address', geometry : { location: latlng } };
    });

    it('populate the address from a GMaps results array', function() {
      address.populate(gmapResult);
      expect(latlng.lat).toHaveBeenCalled();
      expect(latlng.lng).toHaveBeenCalled();
      expect(address.fullAddress).toEqual('address');
    });

  });

});
