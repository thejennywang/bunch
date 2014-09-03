describe('AddressModel:', function() {
  
  var address;

  beforeEach(function() {
    address = new AddressModel();
  });

  describe('defaults', function() {
  
    it('should have a default address of London,UK', function() {
      expect(address.fullAddress).toEqual('London, UK');
    });

    it('should have a default latitude of 51.5286416', function() {
      expect(address.lat).toEqual(51.5286416);
    });

   it('should have a default longitude of -0.1015986', function() {
     expect(address.lng).toEqual(-0.1015986);
   });

 });

  describe('#populate', function() {

    var gmapResult;
    var latlng;

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
