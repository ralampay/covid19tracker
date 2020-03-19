class SurveyAnswer < ApplicationRecord
  belongs_to :survey
  belongs_to :user

  has_many :survey_question_answers, dependent: :delete_all

  validates :date_answered, presence: true

  before_validation :load_defaults

  def load_defaults
    if self.new_record?
      self.date_answered = Date.today
    end
  end
end
