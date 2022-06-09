class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable, :confirmable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :role, presence: true, inclusion: { in: %w(user contact_person admin) }
end
