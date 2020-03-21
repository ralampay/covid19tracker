var Register = (function() {
  var $inputFirstName;
  var $inputLastName;
  var $inputUsername;
  var $inputEmail;
  var $inputPassword;
  var $inputPasswordConfirmation;
  var $message;

  var _authenticityToken;

  var _cacheDom = function() {
    $inputFirstName             = $("#input-first-name");
    $inputLastName              = $("#input-last-name");
    $inputEmail                 = $("#input-reg-email");
    $inputUsername              = $("#input-username");
    $inputPassword              = $("#input-reg-password");
    $inputPasswordConfirmation  = $("#input-password-confirmation");
    $message                    = $(".message");
    $btnRegister                = $("#btn-register");
  };

  var _bindEvents = function() {
    $btnRegister.on("click", function() {
      var firstName             = $inputFirstName.val();
      var lastName              = $inputLastName.val();
      var username              = $inputUsername.val();
      var email                 = $inputEmail.val();
      var password              = $inputPassword.val();
      var passwordConfirmation  = $inputPasswordConfirmation.val();

      $inputFirstName.prop("disabled", true);
      $inputLastName.prop("disabled", true);
      $inputUsername.prop("disabled", true);
      $inputEmail.prop("disabled", true);
      $inputPassword.prop("disabled", true);
      $inputPasswordConfirmation.prop("disabled", true);
      $btnRegister.prop("disabled", true);

      $message.html("Registering...");

      var data = {
        first_name: firstName,
        last_name: lastName,
        username: username,
        email: email,
        password: password,
        password_confirmation: passwordConfirmation,
        authenticity_token: _authenticityToken
      };

      $.ajax({
        url: "/api/v1/register",
        method: "POST",
        data: data,
        success: function(response) {
        },
        error: function(response) {
          alert("Error in registering...");
          $inputFirstName.prop("disabled", false);
          $inputLastName.prop("disabled", false);
          $inputUsername.prop("disabled", false);
          $inputEmail.prop("disabled", false);
          $inputPassword.prop("disabled", false);
          $inputPasswordConfirmation.prop("disabled", false);
          $btnRegister.prop("disabled", false);

          $message.html("Error!");
        }
      });
    });
  };

  var init = function(options) {
    _authenticityToken  = options.authenticityToken;

    _cacheDom();
    _bindEvents();
  };

  return {
    init: init
  };
})();
