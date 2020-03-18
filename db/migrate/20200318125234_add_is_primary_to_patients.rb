class AddIsPrimaryToPatients < ActiveRecord::Migration[5.2]
  def change
    add_column :patients, :is_primary, :boolean
  end
end
