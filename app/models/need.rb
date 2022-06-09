class Need < ApplicationRecord
  belongs_to :calamity
  validates :calamity_id, presence: true
  validates :cost, presence: true, numericality: true
  validates :count, presence: true, numericality: { only_integer: true }
  validates :description, presence: true, length: { maximum: 140 }
end
