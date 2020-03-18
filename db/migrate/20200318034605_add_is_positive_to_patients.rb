class AddIsPositiveToPatients < ActiveRecord::Migration[5.2]
  def change
    add_column :patients, :is_positive, :boolean
  end
end
