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

  })
})
