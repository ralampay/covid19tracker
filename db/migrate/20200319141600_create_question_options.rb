class CreateQuestionOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :question_options, id: :uuid do |t|
      t.references :question, foreign_key: true, type: :uuid
      t.string :label
      t.string :option_type
      t.string :val
      t.integer :priority

      t.timestamps
    end
  end
end
