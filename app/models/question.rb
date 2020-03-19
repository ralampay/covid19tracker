class Question < ApplicationRecord
  QUESTION_TYPES = [
    "single",
    "multiple",
    "single-written",
    "boolean",
    "numeric"
  ]

  belongs_to :survey
  has_many :question_options, dependent: :delete_all

  validates :content, presence: true
  validates :priority, presence: true
  validates :question_type, presence: true, inclusion: { in: QUESTION_TYPES }

  def to_s
    content
  end
end
