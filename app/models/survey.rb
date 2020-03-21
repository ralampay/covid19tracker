class Survey < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :questions, dependent: :delete_all
  has_many :survey_answers, dependent: :delete_all

  def to_s
    name
  end
end
