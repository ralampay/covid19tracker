class QuestionOption < ApplicationRecord
  OPTION_TYPES  = [
    "string",
    "fixed",
    "date"
  ]

  belongs_to :question

  validates :priority, presence: true, numericality: true
  validates :label, presence: true
  validates :val, presence: true
  #validates :option_Type, presence: true, inclusion: { in: OPTION_TYPES }
end
