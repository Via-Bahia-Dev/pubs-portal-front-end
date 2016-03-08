// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require bootstrap-sprockets
//= require jquery_ujs
//= require jquery-fileupload/basic
//= require editable/bootstrap-editable
//= require editable/rails
//= require moment
//= require bootstrap-datetimepicker
//= require select2.full

$(document).ready(function(){
	var tz = jstz.determine();
	document.cookie = 'jstz_time_zone='+window.RailsTimeZone.to(tz.name())+';';

	if($("#home-btn a").attr('href') == window.location.pathname) {
		$("#home-btn").addClass('active');
	} else if ($("#account-btn a").attr('href') == window.location.pathname) {
		$("#account-btn").addClass('active');
	}
	else {
		$("#admin-dropdown li>a").each(function(index, el) {
			if($(el).attr('href') == window.location.pathname) {
				$("#admin-dropdown").addClass('active');
				$(el).closest('li').addClass('active');
			}
		});
	}
});

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

function removeTags(str) {
	return str.replace(/<[^>]+>/g, "")
}
