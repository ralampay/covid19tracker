var Profile = (function() {
  var $inputPassword;
  var $inputConfirmPassword;
  var $btnChangePassword;
  var $inputGroupName;
  var $inputCompany;
  var $btnSaveGroupName;
  var $btnSaveCompany;
  var $message;

  var _authenticityToken;
  var errorsTemplate;

  var _cacheDom = function() {
    $inputPassword        = $("#input-cp-password");
    $inputConfirmPassword = $("#input-cp-confirm-password");
    $btnChangePassword    = $("#btn-change-password");
    $inputGroupName       = $("#input-group-name");
    $inputCompany         = $("#input-company");
    $btnSaveGroupName     = $("#btn-save-group-name");
    $btnSaveCompany       = $("#btn-save-company");
    $message              = $(".message");

    errorsTemplate  = $("#errors-template").html();
  };

  var _bindEvents = function() {
    $btnSaveCompany.on("click", function() {
      var company = $inputCompany.val();

      $.ajax({
        url: "/api/v1/users/update_company",
        method: "POST",
        data: {
          authenticity_token: _authenticityToken,
          company: company
        },
        success: function(response) {
          alert("Successfully updated company!");
        },
        error: function(response) {
          console.log(response);
          alert("Error in updating company!");
        }
      });
    });

    $btnSaveGroupName.on("click", function() {
      var groupName = $inputGroupName.val();

      $.ajax({
        url: "/api/v1/users/update_group_name",
        method: "POST",
        data: {
          authenticity_token: _authenticityToken,
          group_name: groupName
        },
        success: function(response) {
          alert("Successfully updated group name!");
        },
        error: function(response) {
          console.log(response);
          alert("Error in updating group name!");
        }
      });
    });

    $btnChangePassword.on("click", function() {
      var password              = $inputPassword.val();
      var passwordConfirmation  = $inputConfirmPassword.val();

      $inputPassword.prop("disabled", true);
      $inputConfirmPassword.prop("disabled", true);
      $btnChangePassword.prop("disabled", true);

      $message.html("Chaing passwords...");

      $.ajax({
        url: "/api/v1/users/change_password",
        method: "POST",
        data: {
          authenticity_token: _authenticityToken,
          password: password,
          password_confirmation: passwordConfirmation
        },
        success: function(response) {
          $inputPassword.val("");
          $inputConfirmPassword.val("");

          alert("Successfully changed password!");

          window.location.reload();
        },
        error: function(response) {
          var errors = [];

          try {
            errors = JSON.parse(response.responseText).errors;
          } catch(err) {
            console.log(response);
            errors.push("Something went wrong.");
          } finally {
            $inputPassword.prop("disabled", false);
            $inputConfirmPassword.prop("disabled", false);
            $btnChangePassword.prop("disabled", false);

            $message.html(
              Mustache.render(
                errorsTemplate,
                { errors: errors }
              )
            );
          }
        }
      });
    });
  };

  var init  = function(options) {
    _authenticityToken = options.authenticityToken;

    _cacheDom();
    _bindEvents();
  };
  
  return {
    init: init
  };
})();
