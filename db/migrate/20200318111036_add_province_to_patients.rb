class AddProvinceToPatients < ActiveRecord::Migration[5.2]
  def change
    add_column :patients, :province, :string
  end
end
