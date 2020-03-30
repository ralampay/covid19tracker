// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery/dist/jquery
//= require bootstrap/dist/js/bootstrap
//= require mustache/mustache
//= require datatables.net/js/jquery.dataTables.js
//= require datatables.net-bs4/js/dataTables.bootstrap4.js
//= require datatables.net-fixedheader/js/dataTables.fixedHeader.js
//= require datatables.net-fixedheader-bs4/js/fixedHeader.bootstrap4.js


// TODO: Fix ajax login
$(document).ready(function() {
  var $inputEmail       = $("#input-email");
  var $inputPassword    = $("#input-password");
  var $btnLogin         = $("#btn-login");
  var authenticityToken = $("meta[name='csrf-token']").attr('content');


  $btnLogin.on("click", function() {
    var email     = $inputEmail.val();
    var password  = $inputPassword.val();

    $inputEmail.prop('disabled', true);
    $inputPassword.prop('disabled', true);
    $btnLogin.prop('disabled', true);

    $.ajax({
      url: "/api/v1/login",
      method: "POST",
      data: {
        email: email,
        password: password,
        authenticity_token: authenticityToken
      },
      success: function(response) {
        window.location.reload();
      },
      error: function(response) {
        alert("Error in logging in!");

        $inputEmail.prop('disabled', false);
        $inputPassword.prop('disabled', false);
        $btnLogin.prop('disabled', false);
      }
    });
  });
});
