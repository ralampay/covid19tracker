class CreateSurveyQuestionAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :survey_question_answers, id: :uuid do |t|
      t.references :survey_answer, foreign_key: true, type: :uuid
      t.references :question, foreign_key: true, type: :uuid
      t.string :answer

      t.timestamps
    end
  end
end
