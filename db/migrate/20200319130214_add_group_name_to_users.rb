class AddGroupNameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :group_name, :string
  end
end
