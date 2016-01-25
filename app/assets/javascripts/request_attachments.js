// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {

	$("#attachments").on('click', ".attachment-delete", function(e){
		e.preventDefault();
	});

	// Popover for comment delete link
	// using body and selector allows new comments to be selected
	$("#attachments").popover({
		selector: '.attachment-delete',
		placement: 'right',
		html: true,
		trigger: 'focus'
	}).parent().on('click', '#confirm-delete', function() {
		$.ajax({
			// the url is stored in the delete link's val
			// Need to get the parent popover then it's sibling comment-delete
			url: $(this).parents('div.popover').siblings("a.attachment-delete").attr('val'),
			type: 'DELETE'
		})
			.done(function(data) {
				// find the link with the url and close the parent comment div
				$("a[val=\""+$(this)[0].url+"\"]").parents('div.attachment').slideToggle('slow');
			})
			.fail(function(data) {
				console.log(data);
			});
	});
})