var Index = (function() {
  var _authenticityToken;

  var $modalNew;
  var $selectSurvey;
  var $btnNew;
  var $btnConfirmNew;

  var _cacheDom = function() {
    $modalNew       = $("#modal-new");
    $selectSurvey   = $("#select-survey");
    $btnNew         = $("#btn-new");
    $btnConfirmNew  = $("#btn-confirm-new");
  };

  var _bindEvents = function() {
    $btnNew.on("click", function() {
      $modalNew.modal("show");
    });

    $btnConfirmNew.on("click", function() {
      var surveyId  = $selectSurvey.val();

      $selectSurvey.prop("disabled", true);
      $btnConfirmNew.prop("disabled", true);

      $.ajax({
        url: "/api/v1/survey_answers/create",
        method: "POST",
        data: {
          authenticity_token: _authenticityToken,
          survey_id: surveyId
        },
        success: function(response) {
          window.location.href = "/survey_answers/" + response.id;
        },
        error: function(response) {
          alert("Error in creating survey answer");
          $selectSurvey.prop("disabled", false);
          $btnConfirmNew.prop("disabled", false);
        }
      });
    });
  };

  var init  = function(options) {
    _authenticityToken  = options.authenticityToken;

    _cacheDom();
    _bindEvents();
  };

  return {
    init: init
  };
})();
