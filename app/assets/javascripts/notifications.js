$(document).ready(function () {

	$('#venue-container').on('click', '.sms-link', function(event) {
		event.preventDefault();

		$('#newNotificationModal').modal('show');
		
		parentVenue = $(this).closest('.venue-card');
  	$('#meetup_url').val(parentVenue.find('.venue-detail-url').prop('href'));
  	$('#meetup_venue').val(parentVenue.find('.venue-name').text());
	});
	
	
	if( $('#datetimepicker1').length ) {
		$(function () {
	    $('#datetimepicker1').datetimepicker();
		});

		$('#phone_numbers').inputosaurus({
    	width : '350px',
    	allowDuplicate: false,
    	inputDelimiters: [',', ';', ' ']
		});

	};

});