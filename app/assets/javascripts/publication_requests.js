$(document).ready(function() {
	$('#comment_content').keyup(function() {
		formatCommentForm();
	});

	$('#comment-btn').on('click', function(e) {
		e.preventDefault();
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
	});
})


function formatCommentForm () {
	if($("#comment_content").val() == "") {
		$("#comment-btn").attr('disabled', true);
	} else {
		$("#comment-btn").attr('disabled', false);
	}
}
