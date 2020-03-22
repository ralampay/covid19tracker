class User < ApplicationRecord
  ROLES = [
    "ADMIN",
    "USER"
  ]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :role, presence: true, inclusion: { in: ROLES }

  def full_name
    "#{last_name.upcase}, #{first_name.upcase}"
  end

  def to_s
    username
  end

  def login=(login)
    @login =  login
  end

  def login
    @login || self.username || self.email
  end

  def admin?
    self.role == "ADMIN"
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first                                      
      end
    end      
  end 
end
