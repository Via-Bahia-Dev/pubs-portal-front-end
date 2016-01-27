// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {

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
				// prepend the new attachment 
				$new_attachment = $("#attachments").prepend($(data.result).hide().fadeIn());
				$('.progress-bar').toggleClass('progress-bar-info progress-bar-success progress-bar-striped');
				// $('.progress').css('box-shadow', 'inset 0 1px 1px rgba(0, 0, 0, 0.075), 0 0 8px #5cb85c');
				$('.progress-bar').html('Upload Complete');
				setTimeout(function(){
					$('.progress').hide();
					$('.progress-bar').toggleClass('progress-bar-info progress-bar-success progress-bar-striped');
					$('.progress-bar').html('');
				}, 3000);
				$('html, body').animate( { scrollTop: $new_attachment.offset().top - ($(window).height() / 2)}, 1000);
			},
			progress: function(e, data) {
				var progress = parseInt(data.loaded / data.total * 100, 10);
				$('.progress .progress-bar').css(
		            'width',
		            progress + '%'
		        );
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
		$("#attachment-modal").css('display', 'block');
		$("#attachment-modal .modal-content").attr('src', $(this).find(".media-object").data('orig'));
		$("#attachment-modal #caption #name").html($(this).find(".filename").html());
		$("#attachment-modal #caption #details").html($(this).find(".details").html());
		$("#attachment-modal #caption #options a").attr('href', $(this).find(".attachment-thumb-options a").attr('href'));
	});

	$("#attachment-modal .close").click(function(){
		$("#attachment-modal").css('display', 'none');
	});

	$("#attachments").on('click', '.attachment-delete', function(e) {
		e.preventDefault();
		e.stopImmediatePropagation();
	});

	$("#attachments").on('click', '.attachment-download', function(e) {
		e.stopImmediatePropagation();
	});

	


})