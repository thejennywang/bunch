$(document).ready( function () {

	$('.find-venues').on('click', function(event) {
    event.preventDefault();

		$.get(this.href, function(data) {
			console.log(data);
		});
  });
});