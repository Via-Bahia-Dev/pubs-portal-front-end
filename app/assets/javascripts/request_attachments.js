// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {

	$('.attachment-btn').on('click', function(e) {
		e.preventDefault();
	})

	$("#new_comment").popover({
		selector: '.attachment-btn',
		placement: 'right',
		html: true,
		trigger: 'focus',
		title: "Attach From..."
	}).parent().on('click', '.attach-file', function(e) {
		// attach the jquery fileupload event listener on the file attachment form
		// This will automatically send an ajax request to the request_attachment 
		// create action with params based off the form
		$("#new_request_attachment").fileupload({
			dataType: 'html',
			done: function(e, data) {
				// prepend the new attachment 
				$new_attachment = $("#attachments").prepend($(data.result).hide().fadeIn());
				$('html, body').animate( { scrollTop: $new_attachment.offset().top - ($(window).height() / 2)}, 1000);
			}
		});
	});

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