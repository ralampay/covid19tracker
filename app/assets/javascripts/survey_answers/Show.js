var Show  = (function() {
  var _authenticityToken;

  var $modalFinalize;
  var $btnSubmit;
  var $btnFinalize;
  var $btnConfirmFinalize;

  var _cacheDom = function() {
    $modalFinalize      = $("#modal-finalize");
    $btnSubmit          = $(".btn-submit");
    $btnFinalize        = $("#btn-finalize");
    $btnConfirmFinalize = $("#btn-confirm-finalize");
  };

  var _bindEvents = function() {
    $btnFinalize.on("click", function() {
      $modalFinalize.modal("show");
    });

    $btnSubmit.on("click", function() {
    });

    $btnConfirmFinalize.on("click", function() {
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
