class SurveyQuestionAnswer < ApplicationRecord
  belongs_to :survey_answer
  belongs_to :question
end
