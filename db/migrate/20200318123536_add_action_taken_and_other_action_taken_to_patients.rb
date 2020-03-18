class AddActionTakenAndOtherActionTakenToPatients < ActiveRecord::Migration[5.2]
  def change
    add_column :patients, :action_taken, :string
    add_column :patients, :other_action_taken, :string
  end
end
