class ContactPerson < ApplicationRecord
  belongs_to :area
  belongs_to :user
  validates :area_id, presence: true
  validates :user_id, presence: true
end
