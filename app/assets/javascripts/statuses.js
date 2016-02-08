$(document).ready(function() {
  $(".workflow").on("click", ".btn", function(e) {
    $.ajax({
      url: window.location.pathname,
      type: 'PUT',
      dataType: 'json',
      data: {publication_request: { status_id: $(this).data('id')} }
    })
    .done(function(data) {
      console.log("success");
      $(".workflow").html(data);
    })
    .fail(function(data) {
      console.log("error");
      console.log(data);
      $(".workflow").html(data.responseText);
    })
    .always(function() {
      console.log("complete");
    });

  });

  var primary = "#337ab7"
  var success = "#5cb85c"
  var info    = "#5bc0de"
  var warning = "#f0ad4e"
  var danger  = "#d9534f"
  var swatches = [primary, success, info, warning, danger]

  $("input.color").each(function(index, el) {
    var rgb = $(el).parents(".status").children('.name').children('.status-display').css('background-color').match(/\d+/g);
    var hex = '#'+ String('0' + Number(rgb[0]).toString(16)).slice(-2) + String('0' + Number(rgb[1]).toString(16)).slice(-2) + String('0' + Number(rgb[2]).toString(16)).slice(-2);
    $(el).minicolors({
      theme: 'bootstrap',
      defaultValue: hex,
      swatches: ['#fff', '#000']
    });
  });

  $("input.color").blur(function(event) {
    $.ajax({
      url: '/statuses/' + $(this).parents(".status").data('id'),
      type: 'PUT',
      dataType: 'json',
      data: {status: {color: $(this).val()}}
    })
    .done(function(data) {
      console.log("success");
      var id = data['id']
      $(".status[data-id="+id+"] .status-display").css('background-color', data['status']['color']);
    })
    .fail(function() {
      console.log("error");
    })
    .always(function() {
      console.log("complete");
    });

  });


})
