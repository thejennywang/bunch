$(document).ready(function () {

	$('#newNotificationModal').on('show.bs.modal', function (e) {
  	$('#meetup_url').val($('#venue-detail-url').prop('href'));
	})
	
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