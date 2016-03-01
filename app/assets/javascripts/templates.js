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

  $(".templates").popover({
    selector: '.template-delete',
    title: 'Delete Template?',
    placement: 'left',
    html: true,
    trigger: 'focus'
  }).parent().on('click', '#confirm-delete', function () {
    $.ajax({
      url: $(this).parents('div.popover').siblings('a.template-delete').attr('val'),
      type: 'DELETE',
    })
    .done(function() {
      $("a[val=\""+$(this)[0].url+"\"]").parents('tr.template').slideToggle('slow');
    })
    .fail(function() {
      console.log("error");
    })
    .always(function() {
      console.log("complete");
    });

  });

  $("#template_all_tags").select2({
    theme: 'bootstrap',
    tags: true,
    tokenSeparators: [','],
    placeholder: 'Select tags or create new ones'
  })

});
