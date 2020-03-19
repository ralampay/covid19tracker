class AddIsDeceasedToPatients < ActiveRecord::Migration[5.2]
  def change
    add_column :patients, :is_deceased, :boolean
  end
end
