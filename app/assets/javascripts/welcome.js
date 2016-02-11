// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function() {
	$("#create-request-templates").hide();

	$("#create-request-btn").click(function(e) {
		$("#create-request-btn span").toggleClass("rotate");
		$("#create-request-templates").slideToggle();
		createWall();
	});

	$("#create-request-templates").click(function(e) {
		e.stopImmediatePropagation();
	});

	$("#current-requests").hide();
	$("#view-requests-btn").click(function() {
		$("#view-requests-btn span").toggleClass("rotate");
		$("#current-requests").slideToggle();
	});

	$("#current-requests").click(function(e) {
		e.stopImmediatePropagation();
	});


	var parent, ink, d, x, y;
	$(".request-thumb a").click(function(e) {
		parent = $(this).parent();
		//create .ink element if it doesn't exist
		if(parent.find(".ink").length == 0)
			parent.prepend("<span class='ink'></span>");

		ink = parent.find(".ink");
		//incase of quick double clicks stop the previous animation
		ink.removeClass("animate");

		//set size of .ink
		if(!ink.height() && !ink.width())
		{
			//use parent's width or height whichever is larger for the diameter to make a circle which can cover the entire element.
			d = Math.max(parent.outerWidth(), parent.outerHeight());
			ink.css({height: d, width: d});
		}

		//get click coordinates
		//logic = click coordinates relative to page - parent's position relative to page - half of self height/width to make it controllable from the center;
		x = e.pageX - parent.offset().left - ink.width()/2;
		y = e.pageY - parent.offset().top - ink.height()/2;

		//set the position and add class .animate
		ink.css({top: y+'px', left: x+'px'}).addClass("animate");
	})
})

function createWall() {
	var wall = new freewall("#templates-wall");
	wall.reset({
		selector: '.template-cell',
		animate: true,
		// cellW: '20',
		cellH: '30', // we're using medium images which always have a height of 300
		fixSize: false,
		onResize: function() {
			wall.refresh();
		}
	});
	wall.fitWidth();

	// var wall2 = new freewall("#requests-wall");
	// wall2.reset({
	// 	selector: '.request-cell',
	// 	animate: true,
	// 	cellW: 20,
	// 	cellH: 200,
	// 	onResize: function() {
	// 		wall2.fitWidth();
	// 	}
	// });
	// wall2.fitWidth();

	$(window).trigger("resize");
}
