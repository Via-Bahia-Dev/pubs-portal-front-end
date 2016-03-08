// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
	$.fn.editable.defaults.mode = 'inline';
  $.fn.editable.defaults.send = 'always';
  $.fn.editable.defaults.ajaxOptions = {type: "PUT"};

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

	$("#comments").on('click', '.comment-edit', function(event) {
		event.preventDefault();
		var $comment = $(this).parents('.comment').find('.comment-content .text');
		var currentComment = $comment.html().trim();
		currentComment = replaceNewLineTags(currentComment);
		currentComment = removeTags(currentComment);
		if($comment.siblings('.edit-comment-form').length) {
			return;
		}
		$comment.after('<div class="edit-comment-form">'+
                          '<div class="form-group">'+
                            '<div class="input-group edit-comment">' +
                                '<textarea class="form-control" rows="5" name="comment[content]" >' + currentComment + '</textarea>' +
                            '</div>' +
                        '</div>'+
                        // buttons
                        '<div class="editable-buttons">'+
                            '<button type="submit" class="btn btn-primary btn-sm editable-submit">'+
                                '<i class="glyphicon glyphicon-ok"></i>'+
                            '</button>'+
                            '<button type="button" class="btn btn-default btn-sm editable-cancel">'+
                                '<i class="glyphicon glyphicon-remove"></i>'+
                            '</button>'+
                        '</div>'+
                    '</div>');
		$comment.hide();
	});

	// Cancel button clicked
  $("#comments").on('click', '.editable-cancel', function(event) {
    cancelEditComment(this);
  });

	/*
   * Cancel the comment edit
   * Reveals the original field and removes the form
   */
  function cancelEditComment(element) {
    $(element).parents('.edit-comment-form').siblings('.text').show();
    $(element).parents('.edit-comment-form').remove();
  }

	/*
   * Inline form submission
   * Gets the necessary params from the data attributes of the original field
   * Then submits an ajax request
   * On success, give the original field the new value and then show it and remove the form
   */
  $("#comments").on('click', '.editable-submit', function(event) {
    event.preventDefault();
    $field = $(this).parents('.comment-content');
    var model = $field.data('model');
    var name = $field.data('name');
    var val = $field.find('.edit-comment-form textarea').val();

    var params = {}
    params[model] = {}
    params[model][name] = val;

    $.ajax({
      url: $field.data('url'),
      type: 'PUT',
      data: params
    })
    .done(function(data) {
      console.log("success");
			$field.find('.text').html(simpleFormat(val));
      $field.find('.text').show();
      $('.edit-comment-form').remove();
			// $field.parents('.comment').find('.comment-edit').show();
    })
    .fail(function() {
      console.log("error");
    })
    .always(function() {
      console.log("complete");
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

/*
 * Does inverse of ruby's simple_format
 * Adding 2 new lines per p tag and 1 per br
 * Javascript will already do the new lines for p tags, only need to do br
 */
function replaceNewLineTags(str) {
	return str.replace(/<br ?\/>/g, "<br/>\n");
}

/*
 * Does equivalent of ruby's simple_format
 * Replaces new lines with appropriate br or p tags
 */
function simpleFormat(str) {
	var returnRegex = /\r\n?/g;
	var twoNewLineRegex = /\n\n+/g;
	var oneNewLineRegex = /([^\n]\n)(?=[^\n])/g;
	var fstr = str;
	fstr = fstr.replace(returnRegex, "\n") // \r\n and \r -> \n
	fstr = fstr.replace(twoNewLineRegex, "</p>\n\n<p>") // 2+ newline  -> paragraph
	fstr = fstr.replace(oneNewLineRegex, "$1<br/>") // 1 newline   -> br
	fstr = "<p>" + fstr + "</p>"; // surround with p tags
	return fstr;
}

function removeTags(string) {
	return string.replace(/<[^>]+>/g, "")
}
