class FetchRegions
  attr_accessor :data, :regions_hash

  def initialize
    self.data = {
      regions: []
    }

    self.regions_hash = JSON.parse(File.read('app/assets/javascripts/regions.json'))
  end

  def execute!
    self.data[:regions] = regions_hash.keys.map{ |k| 
                            { 
                              name: regions_hash[k]["region_name"], 
                              provinces: regions_hash[k]["province_list"].keys.map{ |kk| 
                                { 
                                  name: kk, 
                                  municipalities: regions_hash[k]["province_list"][kk]["municipality_list"].keys.map{ |kkk| 
                                    { 
                                      name: kkk, 
                                      villages: regions_hash[k]["province_list"][kk]["municipality_list"][kkk]["barangay_list"].map{ |kkkk|
                                        {
                                          name: kkkk
                                        }
                                      }
                                    } 
                                  } 
                                } 
                              } 
                            } 
                          }
  end
end
