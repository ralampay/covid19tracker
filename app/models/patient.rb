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

  ACTIONS_TAKEN = [
    "Take Medicine",
    "Visit Health Center",
    "Visit Clinic / Hospital",
    "None",
    "Others"
  ]

  belongs_to :user
  belongs_to :patient, optional: true

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :region, presence: true
  validates :province, presence: true
  validates :city, presence: true
  validates :village, presence: true
  #validates :temperature, presence: true, numericality: true
  #validates :date_of_birth, presence: true
  validates :gender, presence: true, inclusion: { in: GENDERS }
  validates :classification, presence: true, inclusion: { in: CLASSIFICATIONS }
  validates :action_taken, presence: true, inclusion: { in: ACTIONS_TAKEN }
  validates :other_action_taken, presence: true, if: :other_action_taken?
  validate :is_primary_valid

  serialize :symptoms, Array
  serialize :needs, Array

  before_validation :load_defaults

  def is_primary_valid
    if self.patient.present? and self.is_primary == true
      errors.add(:is_primary, "Cannot be primary since associated with another primary record")
    end
  end

  def to_s
    full_name
  end

  def load_defaults
  end

  def other_action_taken?
    self.action_taken == "Others"
  end

  def full_name
    "#{self.last_name.upcase}, #{self.first_name.upcase} #{self.middle_name.try(:upcase)}"
  end
  
  # TODO: Proper computation of age
  def age
    if self.date_of_birth.present?
      Date.today.year - self.date_of_birth.year
    else
      "N/A"
    end
  end
end
