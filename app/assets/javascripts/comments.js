// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {

	$("#comments").on('click', ".comment-delete", function(e){
		e.preventDefault();
	});

	// Popover for comment delete link
	// using body and selector allows new comments to be selected
	$("#comments").popover({
		selector: '.comment-delete',
		placement: 'right',
		html: true,
		trigger: 'focus'
	}).parent().on('click', '#confirm-delete', function() {
		$.ajax({
			// the url is stored in the delete link's val
			// Need to get the parent popover then it's sibling comment-delete
			url: $(this).parents('div.popover').siblings("a.comment-delete").attr('val'),
			type: 'DELETE'
		})
			.done(function(data) {
				// find the link with the url and close the parent comment div
				$("a[val=\""+$(this)[0].url+"\"]").parents('div.comment').slideToggle('slow');
			})
			.fail(function(data) {
				console.log(data);
			});
	});
})