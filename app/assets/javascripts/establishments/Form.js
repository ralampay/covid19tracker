var Form  = (function() {
  var _data;
  var _region;
  var _province;
  var _city;
  var _village;

  var $selectRegion;
  var $selectCity;
  var $selectVillage;

  var _cacheDom = function() {
    $selectRegion   = $("#select-region");
    $selectProvince = $("#select-province");
    $selectCity     = $("#select-city");
    $selectVillage  = $("#select-village");
  };

  var _bindEvents = function() {
    $selectRegion.html("");
    $selectProvince.html("");

    for(var i = 0; i < _data.regions.length; i++) {
      $selectRegion.append("<option value='" + _data.regions[i].name + "'>" + _data.regions[i].name + "</option>");
    }

    $selectRegion.val(_region);

    _populateProvinces();

    $selectProvince.val(_province);

    _populateCities();

    $selectCity.val(_city);

    _populateVillages();

    $selectVillage.val(_village);

    $selectRegion.on("change", function() {
      _region   = $selectRegion.val();
      _province = "";
      _city     = "";
      _village  = "";
      _populateProvinces();
      _populateCities();
      _populateVillages();
    });

    $selectProvince.on("change", function() {
      _province = $selectProvince.val();
      _city     = "";
      _village  = "";
      _populateCities();
      _populateVillages();
    });

    $selectCity.on("change", function() {
      _city     = $selectCity.val();
      _village  = "";
      _populateVillages();
    });
  };

  var _populateProvinces  = function() {
    var regionObject  = _data.regions.filter(function(o) {
                          return o.name == _region;
                        })[0];

    $selectProvince.html("");

    for(var i = 0; i < regionObject.provinces.length; i++) {
      var p = regionObject.provinces[i].name;

      if(!_province && i == 0)
        _province = p;

      $selectProvince.append("<option value='" + p + "'>" + p + "</option>");
    }

    $selectProvince.val(_province);
  };

  var _populateCities = function() {
    var regionObject  = _data.regions.filter(function(o) {
                          return o.name == _region;
                        })[0];

    var provinceObject  = regionObject.provinces.filter(function(o) {
                            return o.name == _province;
                          })[0];

    $selectCity.html("");

    for(var i = 0; i < provinceObject.municipalities.length; i++) {
      var c = provinceObject.municipalities[i].name;

      if(!_city && i == 0)
        _city = c;

      $selectCity.append("<option value='" + c + "'>" + c + "</option>");
    }

    $selectCity.val(_city);
  };

  var _populateVillages = function() {
    var regionObject  = _data.regions.filter(function(o) {
                          return o.name == _region;
                        })[0];

    var provinceObject  = regionObject.provinces.filter(function(o) {
                            return o.name == _province;
                          })[0];

    var cityObject  = provinceObject.municipalities.filter(function(o) {
                        return o.name == _city;
                      })[0];

    $selectVillage.html("");

    for(var i = 0; i < cityObject.villages.length; i++) {
      var v = cityObject.villages[i].name;

      if(!_village && i == 0)
        _village = v;

      $selectVillage.append("<option value='" + v + "'>" + v + "</option>");
    }

    $selectVillage.val(_village);
  };

  var init  = function(options) {
    _data     = options.data;
    _region   = options.region;
    _province = options.province;
    _city     = options.city;
    _village  = options.village;

    if(!_region) {
      _region   = _data.regions[0].name;
    }
    
    if(!_province) {
      _province = _data.regions[0].provinces[0].name;
    }

    if(!_city) {
      _city     = _data.regions[0].provinces[0].municipalities[0].name;
    }

    if(!_village) {
      _village  = _data.regions[0].provinces[0].municipalities[0].villages[0].name;
    }

    _cacheDom();
    _bindEvents();
  };

  return {
    init: init
  };
})();
