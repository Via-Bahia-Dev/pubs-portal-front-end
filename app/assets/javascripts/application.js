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
//= require select2

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
})
