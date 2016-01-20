// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
	$(".comment-delete").click(function(e){
		e.preventDefault();
		$.ajax({
			url: $(this).attr('val'),
			type: 'DELETE'
		})
			.done(function(data) {
				console.log(data);
				$("a[val=\""+$(this)[0].url+"\"]").parents('div.comment').slideToggle('slow');
			})
			.fail(function(data) {
				console.log(data);
			});
	});
})