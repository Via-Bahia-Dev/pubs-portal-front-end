$(document).ready(function() {
  $(".workflow").on("click", ".btn", function(e) {
    $.ajax({
      url: window.location.pathname,
      type: 'PUT',
      dataType: 'json',
      data: {publication_request: { status_id: $(this).data('id')} }
    })
    .done(function() {
      console.log("success");
      location.reload();
    })
    .fail(function(data) {
      console.log("error");
      console.log(data);
    })
    .always(function() {
      console.log("complete");
    });

  })
})
