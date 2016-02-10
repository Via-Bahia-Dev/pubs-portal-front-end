$(document).ready(function() {
  $.fn.editable.defaults.mode = 'inline';
  $.fn.editable.defaults.send = 'always';
  $.fn.editable.defaults.ajaxOptions = {type: "PUT"};

  $(".editable-field#event-field").editable({
    display: function(value) {
      $(this).text(value);
      $(this).append('<span class="glyphicon glyphicon-pencil overlay-icon"></span>')
    },
    success: function(response, newValue) {
        $(".page-header h1").html(newValue);
    }

  });

  $(".editable-field#dimen-field").editable({
    display: function(value) {
      $(this).text(value);
      $(this).append('<span class="glyphicon glyphicon-pencil overlay-icon"></span>')
    },
    success: function(response, newValue) {

    }
  });

  $(".editable-field#descr-field").editable({

  });

  $(".editable-field#designer-field").editable({
    display: function(value, sourceData) {
      $(this).text($.fn.editableutils.itemsByValue(value, sourceData)[0].text);
      $(this).append('<span class="glyphicon glyphicon-pencil overlay-icon"></span>')
    }
  });

  $(".editable-field#reviewer-field").editable({
    display: function(value, sourceData) {
      $(this).text($.fn.editableutils.itemsByValue(value, sourceData)[0].text);
      $(this).append('<span class="glyphicon glyphicon-pencil overlay-icon"></span>')
    }
  });

  var currentDatePicker = '';
  $("#dates-list").on('click', '.editable-field#rough-date', function(event) {
    event.preventDefault();
    var currentDate = $(this).children('span.date').html();
    $(this).after('<div class="form-inline date-form">'+
                          '<div class="form-group date-field">'+
                            '<div class="input-group date" id="rough-date-picker">' +
                                '<input type="text" class="form-control" value='+currentDate+' />' +
                                '<span class="input-group-addon">' +
                                    '<span class="glyphicon glyphicon-calendar"></span>' +
                                '</span>' +
                            '</div>' +
                        '</div>'+
                        '<div class="editable-buttons"><button type="submit" class="btn btn-primary btn-sm editable-submit"><i class="glyphicon glyphicon-ok"></i></button><button type="button" class="btn btn-default btn-sm editable-cancel"><i class="glyphicon glyphicon-remove"></i></button></div>'+
                      '</div>');
    $(this).hide();
    currentDatePicker = $("#rough-date-picker").datetimepicker({
      format: 'MM/DD/YYYY',
      showTodayButton: true
    });
  });

  $("#dates-list").on('click', '.editable-cancel', function(event) {
    $(this).parents('.date-form').siblings('.editable-field').show();
    $(this).parents('.form-inline').remove();
  });

  $("#dates-list").on('click', '.editable-submit', function(event) {
    event.preventDefault();
    $field = $($(this).parents('.date-form').siblings('.editable-field').get(0));
    var model = $field.data('model');
    var name = $field.data('name');
    var val = $($(this).parents('.date-form').get(0)).find('input').val();

    var params = {
      [model]: {
        [name]: val
      }
    };
    $.ajax({
      url: $field.data('url'),
      type: 'PUT',
      dataType: 'json',
      data: params
    })
    .done(function(data) {
      console.log("success");
      var newVal = $('.date-form input').val();
      $('.editable-field:hidden .date').html(newVal);
      $('.editable-field:hidden').show();
      $('.date-form').remove();
      // $('div[data-url=\"'+$(this).get(0).url+'\"]').show();
    })
    .fail(function() {
      console.log("error");
    })
    .always(function() {
      console.log("complete");
    });

  });

});
