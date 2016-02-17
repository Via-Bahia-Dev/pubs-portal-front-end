$(document).ready(function() {
  $.fn.editable.defaults.mode = 'inline';
  $.fn.editable.defaults.send = 'always';
  $.fn.editable.defaults.ajaxOptions = {type: "PUT"};

  function textFieldDisplay(element, value) {
    $(element).text(value);
    $(element).append('<span class="glyphicon glyphicon-pencil overlay-icon"></span>');
  }

  $(".editable-field").editable({
    display: function(value) {
      textFieldDisplay(this, value);
    }
  });
});
