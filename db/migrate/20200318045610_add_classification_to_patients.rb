class AddClassificationToPatients < ActiveRecord::Migration[5.2]
  def change
    add_column :patients, :classification, :string
  end
end
