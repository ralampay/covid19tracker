class Question < ApplicationRecord
  QUESTION_TYPES = [
    "single",
    "multiple",
    "single-written",
    "numeric",
    "date"
  ]

  belongs_to :survey
  has_many :question_options, dependent: :delete_all
  has_many :survey_question_answers, dependent: :delete_all

  validates :content, presence: true
  validates :priority, presence: true
  validates :question_type, presence: true, inclusion: { in: QUESTION_TYPES }

  def to_s
    content
  end
end
