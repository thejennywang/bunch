$(document).ready( function () {
	
	if ( $('#main_map_holder').length ) {

		var styleArray = [
	    {
	      "featureType": "water",
	      "stylers": [
	        {
	          "visibility": "on"
	        },
	        {
	          "color": "#acbcc9"
	        }
	      ]
	    },
	    {
	      "featureType": "landscape",
	      "stylers": [
	        {
	          "color": "#f2e5d4"
	        }
	      ]
	    },
	    {
	      "featureType": "road.highway",
	      "elementType": "geometry",
	      "stylers": [
          {
            "color": "#c5c6c6"
          }
        ]
	    },
	    {
        "featureType": "road.arterial",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#e4d7c6"
          }
        ]
	    },
	    {
        "featureType": "road.local",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#fbfaf7"
          }
        ]
	    },
	    {
        "featureType": "poi.park",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#c5dac6"
          }
        ]
	    },
	    {
        "featureType": "administrative",
        "stylers": [
          {
            "visibility": "on"
          },
          {
            "lightness": 33
          }
        ]
	    },
	    {
        "featureType": "road"
	    },
	    {
        "featureType": "poi.park",
        "elementType": "labels",
        "stylers": [
          {
            "visibility": "on"
          },
          {
            "lightness": 20
          }
        ]
	    },
	    {},
	    {
        "featureType": "road",
        "stylers": [
          {
            "lightness": 20
          }
        ]
	    }
		]

		var midpointId = $('#midpoint_id').text();

		$.get('/midpoints/' + midpointId +'/json_data', function(coordinates) {

				mainMap = new GMaps ({
					styles: styleArray,
					div: '#main_map',
					lat: coordinates.midpoint.lat,
		      lng: coordinates.midpoint.lng,

		      mapTypeControl: false,
		      streetViewControl: false,
		      panControl: false,
		      zoomControlOpt: { position: 'RIGHT_BOTTOM' }
				});

				mainMap.addMarker ({
					lat: coordinates.midpoint.lat,
		      lng: coordinates.midpoint.lng,
		      icon: { url: '/assets/midpoint_pin.png' },
		      id: 'midpoint'
		    });

				coordinates.address.forEach(function(object, index) {
					mainMap.addMarker ({
						lat: coordinates.address[index].lat,
						lng: coordinates.address[index].lng,
						id: 'address_' + (index + 1).toString()
					});

					mainMap.drawRoute({
						origin: [coordinates.midpoint.lat, coordinates.midpoint.lng],
						destination: [coordinates.address[index].lat, coordinates.address[index].lng],
						travelMode: 'driving',
					  strokeColor: 'royalblue',
					  strokeOpacity: 0.6,
					  strokeWeight: 3
					});
				});

				mainMap.fitZoom();
				mainMap.setCenter(coordinates.midpoint.lat, coordinates.midpoint.lng - 0.02);
		});

	};

});