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

  $(".role-check-box").change(function(event) {
    $.ajax({
      url: $("#set-roles").data('url'),
      type: 'PUT',
      data: { user: { roles: chosenRoles() } }
    })
    .done(function() {
      console.log("success");
    })
    .fail(function() {
      console.log("error");
    })
    .always(function() {
      console.log("complete");
    });

  });

  function chosenRoles() {
    var roles = []
    $(".role-check-box").each(function(index, el) {
      if($(el).prop('checked') == true) {
        roles.push($(el).val());
      }
    });
    return roles;
  }
});
