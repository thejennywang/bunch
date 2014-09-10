describe('MidpointModel:', function() {
  
  var midpointData = {"midpoint":{"lat":51.5,"lng":-0.3},
  "address":[{"lat":51.4,"lng":-0.1},
  {"lat":51.6,"lng":-0.5}]};

  beforeEach(function() {
    midpoint = new MidpointModel(midpointData);
  });

  describe('initialization', function() {

    it('should have a lat', function() {
      expect(midpoint.lat).toEqual(51.5);
    });

    it('should have a lng', function() {
      expect(midpoint.lng).toEqual(-0.3);
    });

    it('should have a default radius of 250', function() {
      expect(midpoint.radius).toEqual(250);
    });

    it('should have addresses', function() {
      expect(midpoint.addresses).toEqual([{"lat":51.4,"lng":-0.1},
  {"lat":51.6,"lng":-0.5}]);
    });

  });

  describe('#zoomInBounds', function() {

    it('should zoom in to the radius of the circle', function() {
      console.log(midpoint.zoomInBounds());
      expect(midpoint.zoomInBounds()[0].lat()).toEqual(51.5025)
      expect(midpoint.zoomInBounds()[1].lat()).toEqual(51.4975)
      expect(midpoint.zoomInBounds()[2].lng().toFixed(5)).toEqual('-0.30250')
      expect(midpoint.zoomInBounds()[3].lng().toFixed(5)).toEqual('-0.29750')
    })

  });

  describe('#zoomOutBounds', function() {

    it('should create a dummy bound west of the westernmost address', function() {
      expect(midpoint.createDummyLatLong()).toEqual( new google.maps.LatLng(51.5,-0.6) )
    })

    it('should include the dummy location in the Zoom Out bounds', function() {
      var bounds = midpoint.zoomOutBounds();
      expect(bounds[2].lat()).toEqual(midpoint.createDummyLatLong().lat())
    })

    it('should include the midpoint location in the Zoom Out bounds', function() {
      var bounds = midpoint.zoomOutBounds();
      expect(bounds[3].lat()).toEqual(midpoint.lat)
    })

    it('should include the zoom-in bounds (i.e. the radius of the circle)', function() {
      var bounds = midpoint.zoomOutBounds();
      expect(bounds[3].lat()).toEqual(midpoint.lat)
    })


  });


});