class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions, id: :uuid do |t|
      t.references :survey, foreign_key: true, type: :uuid
      t.string :content
      t.string :question_type
      t.integer :priority

      t.timestamps
    end
  end
end
