$(document).on('turbolinks:load', function() {
  var show_error;
  $("#capture-payment").submit(function (event) {
    var $form = $(this);
    $form.find("input[type=submit]").prop("disabled", true);

    var formDetails = {
      number: $form.find('#card_number').val(),
      cvc: $form.find('#card_verification').val(),
      exp_month: $form.find('#exp_month').val(),
      exp_year: $form.find('#exp_year').val(),
    };

    if (!Stripe.card.validateCardNumber(formDetails.number)) {
      show_error('Please enter a valid credit card number.');
    }

    Stripe.card.createToken(formDetails, stripeResponseHandler);
    return false;
  });
});


function stripeResponseHandler(status, response) {
  var $form, token;
  $form = $("#capture-payment");
  if (response.error) {
    show_error(response.error.message);
    $form.find("input[type=submit]").prop("disabled", false);
  } else {
    token = response.id;
    $form.append($("<input type='hidden' name='stripeToken' />").val(token));
    $("#card_number").remove();
    $("#card_verification").remove();
    $("#exp_month").remove();
    $("#exp_year").remove();
    $form.get(0).submit();
  }
  return false;
};

function show_error(message) {
  $("#flash_messages").html('<div class="alert alert-danger"><a class="close" data-dismiss="alert">×</a>' + message + '</div>');
  // $('.alert').delay(5000).fadeOut(3000);
  return false;
};
