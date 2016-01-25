$(document).ready(function() {
	var ctrlKeyCode = 17;
	var enterKeyCode = 13;

	$('[data-toggle="tooltip"]').tooltip();

	$('#comment_content').keyup(function() {
		formatCommentForm();
	});

	$('#comment-btn').on('click', function(e) {
		e.preventDefault();
		postComment();
	});

	var isCtrlDown = false;
	$('#comment_content').keyup(function(e) {
		if(e.which == ctrlKeyCode)  isCtrlDown = false;
	}).keydown(function(e) {
		if(e.which == ctrlKeyCode) isCtrlDown = true;
		if(isCtrlDown == true) {
			if(e.which == enterKeyCode) {
				postComment();
			}
		}
	});

	$('.attachment-btn').on('click', function(e) {
		e.preventDefault();
	})

	$("#new_comment").popover({
		selector: '.attachment-btn',
		placement: 'right',
		html: true,
		// trigger: 'focus',
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

	$("#new_comment").on('change', ".attach-file", function() {
		// When the file is chosen, automatically upload
		
	})
})


function formatCommentForm () {
	if($("#comment_content").val() == "") {
		$("#comment-btn").attr('disabled', true);
	} else {
		$("#comment-btn").attr('disabled', false);
	}
}

function postComment() {
	// Make ajax call to create comment
	$.ajax({
		url: $("form#new_comment").attr('action'),
		type: 'POST',
		data: { comment: { content: $("#comment_content").val() } }
	})
		.done(function(data) {
			$new_comment = $("#comments").prepend($(data).hide().fadeIn());
			$('html, body').animate( { scrollTop: $new_comment.offset().top - ($(window).height() / 2)}, 1000);
			$("#comment_content").val('');
			formatCommentForm();
	});
}
