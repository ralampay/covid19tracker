class AddContactNumberToPatients < ActiveRecord::Migration[5.2]
  def change
    add_column :patients, :contact_number, :string
  end
end
