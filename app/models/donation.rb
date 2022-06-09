class Donation < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :need_id, presence: true
  validates :amount, presence: true, numericality: true, comparison: { greater_than: 0 }
end
