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

  $("#name-field, #dimen-field, #url-field").editable({
    placeholder: "Empty",
    display: function(value) {
      textFieldDisplay(this, value);
    }
  });

  $(".editable-field#tags-field").editable({
    placeholder: "None",
    display: function(value) {
      $.each(value, function(i) {
        // value[i] needs to have its HTML stripped, as every time it's read, it contains
       // the HTML markup. If we don't strip it first, markup will recursively be added
       // every time we open the edit widget and submit new values.
       value[i] = "<span class='label label-info'>" + $('<p>' + value[i] + '</p>').text() + "</span>";
     });
     $(this).html(value.join(" "));
     $(this).append('<span class="glyphicon glyphicon-pencil overlay-icon"></span>');
   },
    select2: {
      theme: 'bootstrap',
      tags: true,
      tokenSeparators: [','],
      placeholder: 'Select tags or create new ones',
      multiple: true
    }
  });

  $("#tags-field").on('shown', function(event) {
    var editable = $(this).data('editable');
    value = editable.value
    $.each(value,function(i){
       value[i] = $('<p>' + value[i] + '</p>').text()
    });
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

  $(".template-tags, #template_all_tags").select2({
    theme: 'bootstrap',
    tags: true,
    tokenSeparators: [',', '.', ' ', '/', '\\', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '+', '=', '`', '~'],
    placeholder: 'Select tags or create new ones',
    createTag: function(obj) {
      // make all tags lower case
      return { id: obj.term, text: obj.term.toLowerCase(), tag: true }
    }
  });

  $(".template-tags").on('change', function(event) {
    var tags = $(this).val();
    $.ajax({
      url: $(this).data('url'),
      type: 'PUT',
      data: { template: { all_tags: tags } }
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

});
