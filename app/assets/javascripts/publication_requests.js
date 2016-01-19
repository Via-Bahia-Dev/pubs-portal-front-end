$(document).ready(function() {
	$('#comment').keyup(function() {
		formatCommentForm();
	});
})


function formatCommentForm () {
	if($("#comment").val() == "") {
		$("#comment-btn").attr('disabled', true);
	} else {
		$("#comment-btn").attr('disabled', false);
	}
}
