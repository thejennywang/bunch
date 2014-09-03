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

				coordinates.address.forEach(function(object, index) {
					mainMap.addMarker ({
						lat: coordinates.address[index].lat,
						lng: coordinates.address[index].lng,
						id: 'address_' + (index + 1).toString()
					});
				});

				mainMap.fitZoom();

		});

	};

});