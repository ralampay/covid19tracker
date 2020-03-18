class Patient < ApplicationRecord
  STATUSES = [
    "home quarantine",
    "hospital quarantine",
    "skeletal workforce"
  ]

  CLASSIFICATIONS = [
    "Good",
    "PUI",
    "PUM",
    "Victim"
  ]

  GENDERS = [
    "male",
    "female"
  ]

  SYMPTOMS = [
    "fever",
    "cough",
    "difficulty in breathing",
    "sore throat",
    "headache",
    "runny nose",
    "diarhea",
    "nausea or vomitting",
    "weakness or fatigue"
  ]

  NEEDS = [
    "food",
    "water",
    "disinfection",
    "hygiene",
    "medical supplies"
  ]

  NEEDS_STATUS = [
    "manageable",
    "critical"
  ]

  belongs_to :user

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :city, presence: true
  #validates :barangay, presence: true
  #validates :temperature, presence: true, numericality: true
  validates :date_of_birth, presence: true
  validates :gender, presence: true, inclusion: { in: GENDERS }
  validates :classification, presence: true, inclusion: { in: CLASSIFICATIONS }

  serialize :symptoms, Array
  serialize :needs, Array

  before_validation :load_defaults

  def load_defaults
  end

  def full_name
    "#{self.last_name.upcase}, #{self.first_name.upcase} #{self.middle_name.try(:upcase)}"
  end
  
  # TODO: Proper computation of age
  def age
    Date.today.year - self.date_of_birth.year
  end
end
