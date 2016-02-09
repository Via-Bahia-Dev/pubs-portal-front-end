$(document).ready(function() {
  $.fn.editable.defaults.mode = 'inline';
  $.fn.editable.defaults.ajaxOptions = {type: "PUT"};

  $(".editable-field#event-field").editable({
    success: function(response, newValue) {
        $(".page-header h1").html(newValue);
    }

  });

  $(".editable-field#dimen-field").editable({
    success: function(response, newValue) {

    }
  });

  $(".editable-field#descr-field").editable({

  });

});
