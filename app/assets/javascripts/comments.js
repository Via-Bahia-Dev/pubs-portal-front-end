// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {

	var ctrlKeyCode = 17;
	var enterKeyCode = 13;

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
});

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
			$('.container-fluid').animate( { scrollTop: $('.container-fluid').scrollTop() + ($new_comment.offset().top - ($(window).height() / 2))}, 1000);
			$("#comment_content").val('');
			formatCommentForm();
	});
}