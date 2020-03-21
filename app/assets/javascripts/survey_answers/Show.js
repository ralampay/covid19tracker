var Show  = (function() {
  var _authenticityToken;

  var $modalFinalize;
  var $btnSubmit;
  var $btnFinalize;
  var $btnConfirmFinalize;
  var $radioSelection;
  var $answer;

  var _cacheDom = function() {
    $modalFinalize      = $("#modal-finalize");
    $btnSubmit          = $(".btn-submit");
    $btnFinalize        = $("#btn-finalize");
    $btnConfirmFinalize = $("#btn-confirm-finalize");
    $radioSelection     = $(".radio-selection");
    $checkBoxSelection  = $(".check-box-selection");
    $answer             = $(".answer");
  };

  var _bindEvents = function() {
    $radioSelection.on("click", function() {
      if($(this).is(':checked')) {
        var val = $(this).data("val");
        $($(this).data("target")).val(val);
      }
    });

    $checkBoxSelection.on("click", function() {
      var selections = [];
      $($(this).data("group-target")).each(function() {
        if($(this).is(':checked')) {
          selections.push($(this).data("val"));
        }
      });

      $($(this).data("target")).val(selections.join(","));
    });

    $btnFinalize.on("click", function() {
      $modalFinalize.modal("show");
    });

    $btnSubmit.on("click", function() {
      var answer  = $($(this).data("target")).val();
      var id      = $(this).data("id");

      $.ajax({
        url: "/api/v1/survey_answers/submit_answer",
        method: "POST",
        data: {
          id: id,
          answer: answer,
          authenticity_token: _authenticityToken
        },
        success: function(response) {
          alert("Successfully saved answer for this question!");
        },
        error: function(response) {
          alert("Error in saving answer for this question.");
        }
      });
    });

    $btnConfirmFinalize.on("click", function() {
      var id = $(this).data("id");

      var answers = [];

      $answer.each(function() {
        answers.push({
          id: $(this).data("id"),
          answer: $(this).val()
        });
      });

      $(this).prop("disabled", true);

      $.ajax({
        url: "/api/v1/survey_answers/finalize",
        method: "POST",
        data: {
          id: id,
          authenticity_token: _authenticityToken,
          answers: JSON.stringify(answers)
        },
        success: function(response) {
          window.location.reload();
        },
        error: function(response) {
          alert("Error in finalizing answers");
          $btnConfirmFinalize.prop("disabled", false);
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
