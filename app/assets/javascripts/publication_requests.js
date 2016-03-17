$(document).ready(function() {
  $.fn.editable.defaults.mode = 'inline';
  $.fn.editable.defaults.send = 'always';
  $.fn.editable.defaults.ajaxOptions = {type: "PUT"};
  /*
  Make editable fields for the request
  Different elements have slightly different requirements so do them all individually
  */
  $(".editable-field#event-field").editable({
    display: function(value) {
      textFieldDisplay(this, value);
    },
    validate: function(value) {
      return validateRequiredField(value);
    },
    success: function(response, newValue) {
        $(".page-header h1").html(newValue);
    }
  });

  $(".editable-field#dimen-field").editable({
    display: function(value) {
      textFieldDisplay(this, value);
    },
    validate: function(value) {
      return validateRequiredField(value);
    }
  });

  $(".editable-field#descr-field").editable({
    display: function(value) {
      $(this).html(value);
    },
    validate: function(value) {
      return validateRequiredField(value);
    },
    showbuttons: 'bottom'
  });

  $(".editable-field#designer-field").editable({
    display: function(value, sourceData) {
      selectDisplay(this, value, sourceData);
    },
    validate: function(value) {
      return validateRequiredField(value);
    }
  });

  $(".editable-field#reviewer-field").editable({
    display: function(value, sourceData) {
      selectDisplay(this, value, sourceData);
    },
    validate: function(value) {
      return validateRequiredField(value);
    }
  });

  /*
   * Need to make our own editable for date-picker since plugin doesn't support it for Bootstrap 3
   * On click, creates the datepicker form and hides the original field
   * Sets up a listener on clicking outside to close the form when clicking outside
   */
  var currentDatePicker = '';
  $("#dates-list").on('click', '.editable-date', function(event) {
    event.preventDefault();
    var currentDate = $(this).children('span.date').html();
    $(this).after('<div class="form-inline date-form">'+
                          '<div class="form-group date-field">'+
                            '<div class="input-group date">' +
                                '<input type="text" class="form-control" value='+currentDate+' />' +
                                '<span class="input-group-addon">' +
                                    '<span class="glyphicon glyphicon-calendar"></span>' +
                                '</span>' +
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
    $(this).hide();
    currentDatePicker = $(".date-form .date").datetimepicker({
      format: 'MM/DD/YYYY',
      showTodayButton: true
    });

    $(currentDatePicker).bind("clickoutside", function(event) {
      // Check if this is the same item as what was clicked. If not, cancel
      if($(event.target).closest(".item")[0] != $(this).closest(".item")[0]) {
        cancelDate(this);
      }
    });

  });

  // Cancel button clicked
  $("#dates-list").on('click', '.editable-cancel', function(event) {
    cancelDate(this);
  });

  /*
   * Cancel the date edit
   * Reveals the original field and removes the form
   */
  function cancelDate(element) {
    $(element).parents('.date-form').siblings('.editable-field').show();
    $(element).parents('.form-inline').remove();
  }

  /*
   * Inline form submission
   * Gets the necessary params from the data attributes of the original field
   * Then submits an ajax request
   * On success, give the original field the new value and then show it and remove the form
   */
  $("#dates-list").on('click', '.editable-submit', function(event) {
    event.preventDefault();
    $field = $($(this).parents('.date-form').siblings('.editable-field').get(0));
    var model = $field.data('model');
    var name = $field.data('name');
    var val = $($(this).parents('.date-form').get(0)).find('input').val();

    if($.trim(val) == '') {
      if($('.date-form .editable-error-block').length == 0) {
        $('.date-form').append('<div class="editable-error-block help-block">This field is required</div>');
      }
      $('.date-form').addClass('has-error');
    } else {
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
        var newVal = $('.date-form input').val();
        $('.editable-field:hidden .date').html(newVal);
        $('.editable-field:hidden').show();
        $('.date-form').remove();
      })
      .fail(function(data) {
        console.log("error");
        if($('.date-form .editable-error-block').length == 0) {
          $('.date-form').append('<div class="editable-error-block help-block">Something went wrong</div>');
        }
        $('.date-form').addClass('has-error');
      })
      .always(function() {
        console.log("complete");
      });
    }

  });

  $("#chosen-template").popover({
    placement: 'right',
    html: true,
    container: ".editable-template",
    trigger: 'focus',
    title: 'Choose a template'
  });

  $("#chosen-template").on('click', '.template-option', function(event) {
    event.preventDefault();
    $.ajax({
      url: $(this).parents('#chosen-template').val(),
      type: 'PUT',
      data: { publication_request: { template_id : $(this).data('id') } }
    })
    .done(function(data) {
      console.log("success");
      $("#chosen-template").html(data);
    })
    .fail(function() {
      console.log("error");
    })
    .always(function() {
      console.log("complete");
    });

  });

  /* New Form */
  $(".new_publication_request .date").datetimepicker({
    format: 'MM/DD/YYYY',
    showTodayButton: true
  });
  $(".date input").each(function(index, el) {
    if($(el).attr('value')) {
      var d = new Date($(el).attr('value'));
      $(el).val((d.getMonth()+1) + "/" + (d.getDate()+1) + "/" + d.getFullYear());
    }
  });

});
