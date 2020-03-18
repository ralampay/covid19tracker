class AddMiddleNameToPatients < ActiveRecord::Migration[5.2]
  def change
    add_column :patients, :middle_name, :string
  end
end
