class Calamity < ApplicationRecord
  belongs_to :area
  has_many :needs
  validates :area_id, presence: true
  validates :estimated_date_from, presence: true
  validates :estimated_date_to, presence: true, comparison: { greater_than: :estimated_date_from, message: "Should be later than date from."  }
  validates :calamity_type, presence: true
  validates :description, presence: true, length: { maximum: 140 }
end
