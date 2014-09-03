$(document).ready( function () {
	
	if ( $('#main_map_holder').length ) {

		var midpointId = $('#midpoint_id').text();

		$.get(midpointId, function(coordinates) {

				mainMap = new GMaps ({
					div: '#main_map',
					lat: -12.043333,
		      lng: -77.028333
				});

				mainMap.addMarker ({
					lat: -13.043333,
		      lng: -78.028333,
		      id: 1
		    });

				mainMap.addMarker ({
					lat: -14.043333,
		      lng: -79.028333,
		      id: 2
		    });

				mainMap.addMarker ({
					lat: -12.043333,
		      lng: -77.028333,
		      id: 3
				});

		});

	};

});