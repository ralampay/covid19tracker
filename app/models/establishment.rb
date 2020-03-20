class Establishment < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :number_of_people_in_need, presence: true
  validates :contact_person, presence: true
  validates :address, presence: true
  validates :contact_number, presence: true
  validates :region, presence: true
  validates :province, presence: true
  validates :city, presence: true
  validates :village, presence: true

  serialize :needs, Array

  def to_s
    name
  end
end
