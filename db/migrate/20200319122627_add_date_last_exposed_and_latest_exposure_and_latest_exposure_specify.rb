class AddDateLastExposedAndLatestExposureAndLatestExposureSpecify < ActiveRecord::Migration[5.2]
  def change
    add_column :patients, :date_last_exposed, :date
    add_column :patients, :latest_exposure, :string
    add_column :patients, :latest_exposure_specify, :string
  end
end
