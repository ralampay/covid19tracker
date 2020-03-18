class AddRegionToPatients < ActiveRecord::Migration[5.2]
  def change
    add_column :patients, :region, :string
  end
end
