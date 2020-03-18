class AddNeedsAndNeedsStatusToPatients < ActiveRecord::Migration[5.2]
  def change
    add_column :patients, :needs, :string
    add_column :patients, :needs_status, :string
  end
end
