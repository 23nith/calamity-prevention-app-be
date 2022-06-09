class Area < ApplicationRecord
  has_many :users
  has_many :calamities
  has_one :contact_person
  validates :name, presence: true
  validates :address, presence: true, length: { maximum: 140 }
  validates :longitude, presence: true, numericality: true
  validates :latitude, presence: true, numericality: true
  validates :radius, presence: true, numericality: true
end
