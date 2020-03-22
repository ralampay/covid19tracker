class AddIsKeyToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :is_key, :boolean
  end
end
