FactoryBot.define do
  factory :message do
    sender_id { 1 }
    receiver_id { 1 }
    message_content { "MyText" }
  end
end
