$(document).ready(function() {
  $.fn.editable.defaults.mode = 'inline';
  $.fn.editable.defaults.send = 'always';
  $.fn.editable.defaults.ajaxOptions = {type: "PUT"};

  function textFieldDisplay(element, value) {
    if(value === "") {
      $(element).text("Empty");
    } else {
      $(element).text(value);
    }
    $(element).append('<span class="glyphicon glyphicon-pencil overlay-icon"></span>');
  }

  $(".editable-field").editable({
    placeholder: "Empty",
    display: function(value) {
      textFieldDisplay(this, value);
    }
  });

  // Have to add editable-empty class afterwards since x-editable overrides it
  // when using a display function
  $(".editable-field").each(function(index, el) {
    if($(el).text() == "Empty") {
      $(el).addClass('editable-empty')
    }
  });

});
