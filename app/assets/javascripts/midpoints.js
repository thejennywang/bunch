$(document).ready( function () {
	
	if ( $('#main_map_holder').length ) {

		var midpointId = $('#midpoint_id').text();

		$.get('/midpoints/' + midpointId +'/json_data', function(coordinates) {

				mainMap = new GMaps ({
					div: '#main_map',
					lat: coordinates.midpoint.lat,
		      lng: coordinates.midpoint.lng
				});

				mainMap.addMarker ({
					lat: coordinates.midpoint.lat,
		      lng: coordinates.midpoint.lng,
		      id: 'midpoint'
		    });

				mainMap.addMarker ({
					lat: coordinates.address[0].lat,
		      lng: coordinates.address[0].lng,
		      id: 'address_1'
		    });

				mainMap.addMarker ({
					lat: coordinates.address[1].lat,
		      lng: coordinates.address[1].lng,
		      id: 'address_2'
				});

		});

	};

});