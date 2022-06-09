class Area < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true, length: { maximum: 140 }
  validates :longitude, presence: true, numericality: true
  validates :latitude, presence: true, numericality: true
  validates :radius, presence: true, numericality: true
end
