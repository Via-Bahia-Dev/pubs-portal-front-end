// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {

	$('.progress').hide();

	$('.attachment-btn').on('click', function(e) {
		e.preventDefault();
	});

	$("#new_comment").on('change', ".attach-file", function() {
		// When the file is chosen, show the progress bar

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
			send: function(e, data) {
				$(".progress").show();
			},
			done: function(e, data) {
				if($(data.result).closest(".alert").length) {
					// there was an error with the upload
					$("#new_comment").append(data.result);
				} else {
					// prepend the new attachment
					$new_attachment = $("#attachments").prepend($(data.result).hide().fadeIn());
					$('.progress-bar').toggleClass('progress-bar-info progress-bar-success progress-bar-striped');
					$('.progress-bar').html('Upload Complete');
					setTimeout(function(){
						hideProgressBar();
					}, 3000);
					$('.container-fluid').animate( { scrollTop: $('.container-fluid').scrollTop() + ($new_attachment.offset().top - ($(window).height() / 2))}, 1000);
				}
			},
			fail: function(e, data) {
				console.log("fail");
				console.log(data);
			},
			progress: function(e, data) {
				var progress = parseInt(data.loaded / data.total * 100, 10);
				$('.progress .progress-bar').css(
		            'width',
		            progress + '%'
		        );
			},
			always: function(e, data) {
				hideProgressBar();
			}
		});
	});

	// Popover for comment delete link
	// using body and selector allows new comments to be selected
	$("#attachments").popover({
		selector: '.attachment-delete',
		placement: 'right',
		html: true,
		trigger: 'focus'
	});

	$("#attachments").on('click', '#confirm-delete', function(e) {
		e.stopPropagation();
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

	$("#attachments").on('click', '.attachment', function(e) {

		// If this is an image, show the modal
		if($(this).find(".image").length) {
			$("#attachment-modal").css('display', 'block');
			$("#attachment-modal .modal-content").attr('src', $(this).find(".media-object").data('orig'));
			$("#attachment-modal #caption #name").html($(this).find(".filename").html());
			$("#attachment-modal #caption #details").html($(this).find(".details").html());
			$("#attachment-modal #caption #options a").attr('href', $(this).find(".attachment-thumb-options a").attr('href'));
		} else {
			e.preventDefault();
			// window.open($('.non-image .attachment-download').prop('href'), '_blank');
			// window.location.href = $('.non-image .attachment-download').attr('href');
		}
	});

	$("#attachment-modal .close").click(function(){
		$("#attachment-modal").css('display', 'none');
	});

	$(document).keyup(function(e) {
		if(e.keyCode == 27 && $("#attachment-modal").css('display') === 'block')
			$("#attachment-modal").css('display', 'none');
	});

	$("#attachments").on('click', '.attachment-delete', function(e) {
		e.preventDefault();
		e.stopImmediatePropagation();
	});

	$("#attachments").on('click', '.attachment-download', function(e) {
		e.stopImmediatePropagation();
	});

});

function hideProgressBar() {
	$('.progress').hide();
	$('.progress-bar').toggleClass('progress-bar-info progress-bar-success progress-bar-striped');
	$('.progress-bar').html('');
}
