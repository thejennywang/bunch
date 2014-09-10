$(document).ready( function () {
	
	if ( $('#main_map_holder').length ) {

		var midpointId = $('#midpoint_id').text();
		var addressIcon = '/assets/red-marker.png';

		$.get('/midpoints/' + midpointId +'/json_data', function(coordinates) {
            var radius = 500;
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

			});


            var westLngs = coordinates.address.map(function(address){ return address.lng })
            var addressMinLng = Math.max.apply(null, westLngs);
            var midpointLng = coordinates.midpoint.lng
            var distance = midpointLng-addressMinLng;

			mainMap.fitZoom();

			// Zooms the view in to the midpoint radius
            $('#map-zoom-in').on( 'click', function () {
                mainMap.fitLatLngBounds(midpointZoomInBounds())
            })
            // And back out again
            $('#map-zoom-out').on( 'click', function () {
                mainMap.fitLatLngBounds(midpointZoomOutBounds())
            })

            function midpointZoomInBounds() {
                var max_north = new google.maps.LatLng(coordinates.midpoint.lat  + radius/111258, coordinates.midpoint.lng)
                var max_south = new google.maps.LatLng(coordinates.midpoint.lat  - radius/111258,coordinates.midpoint.lng)
                return [max_north,max_south]
            }

            function createLatLong(geolocation){
                return new google.maps.LatLng(geolocation.lat,geolocation.lng)
            }

            function createDummyLatLong(){
                return new google.maps.LatLng(coordinates.midpoint.lat,addressMinLng-distance)
            }

            function midpointZoomOutBounds() {
                var bounds = coordinates.address.map(function(address){ return createLatLong(address) }) 
                bounds.push(createDummyLatLong())
                return bounds
            }

        });


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

	};

});