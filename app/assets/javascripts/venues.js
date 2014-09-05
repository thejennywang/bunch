$(document).ready( function () {

	$('.find-venues').on('click', function(event) {
    event.preventDefault();

		$.post(this.href, function(data) {
			console.log(data);
		});
  });
});