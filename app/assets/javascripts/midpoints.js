$(document).ready( function () {
	
	if ( $('#main_map_holder').length ) {

		var styleArray = [
    {
        "stylers": [
            {
                "saturation": -100
            }
        ]
    },
    {
        "featureType": "water",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "color": "#0099dd"
            }
        ]
    },
    {
        "elementType": "labels",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "poi.park",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "color": "#aadd55"
            }
        ]
    },
    {
        "featureType": "road.highway",
        "elementType": "labels",
        "stylers": [
            {
                "visibility": "on"
            }
        ]
    },
    {
        "featureType": "road.arterial",
        "elementType": "labels.text",
        "stylers": [
            {
                "visibility": "on"
            }
        ]
    },
    {
        "featureType": "road.local",
        "elementType": "labels.text",
        "stylers": [
            {
                "visibility": "on"
            }
        ]
    },
    {}
]

		var midpointId = $('#midpoint_id').text();
		var addressIcon = '/assets/red-marker.png';

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

				coordinates.address.forEach(function(object, index) {
					mainMap.addMarker ({
						lat: coordinates.address[index].lat,
						lng: coordinates.address[index].lng,
						id: 'address_' + (index + 1).toString(),
						icon: addressIcon,
						class: 'address-marker'
					});

					// mainMap.drawRoute({
					// 	origin: [coordinates.midpoint.lat, coordinates.midpoint.lng],
					// 	destination: [coordinates.address[index].lat, coordinates.address[index].lng],
					// 	travelMode: 'driving',
					//   strokeColor: '#FF6961',
					//   strokeOpacity: 0.6,
					//   strokeWeight: 3
					// });

				});

				mainMap.drawCircle ({
  				lat: coordinates.midpoint.lat,
  				lng: coordinates.midpoint.lng,
  	      radius: 250,
  	      fillColor: "#99cc33",
  	      fillOpacity: 0.5,
  	      strokeColor: "#99cc33",
  	      strokeOpacity: 0,
  	      strokeWeight: 0
		    });

				// mainMap.addMarker ({
				// 	lat: coordinates.midpoint.lat,
		  // 	 lng: coordinates.midpoint.lng,
		  // 	 icon: addressIcon,
		  // 	 id: 'midpoint'
		  // 	});

				mainMap.fitZoom();
				// mainMap.setCenter(coordinates.midpoint.lat, coordinates.midpoint.lng - 0.025);
		});

	};

});