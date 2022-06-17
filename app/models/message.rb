class Message < ApplicationRecord
  validates :sender_id, presence: true
  validates :receiver_id, presence: true
  validates :message_content, presence: true, length: { maximum: 140 }  
end
