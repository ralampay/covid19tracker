class RemoveBarangayAndReplaceAsVillage < ActiveRecord::Migration[5.2]
  def change
    remove_column :patients, :barangay
    add_column :patients, :village, :string
  end
end
