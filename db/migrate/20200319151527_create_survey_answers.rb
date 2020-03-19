class CreateSurveyAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :survey_answers, id: :uuid do |t|
      t.references :survey, foreign_key: true, type: :uuid
      t.references :user, foreign_key: true, type: :uuid
      t.boolean :is_final
      t.date :date_answered

      t.timestamps
    end
  end
end
