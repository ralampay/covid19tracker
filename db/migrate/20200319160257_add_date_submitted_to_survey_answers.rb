class AddDateSubmittedToSurveyAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :survey_answers, :date_submitted, :date
  end
end
