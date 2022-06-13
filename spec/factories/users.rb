FactoryBot.define do
  factory :user do
    email { "test@email.com" }
    password { "Password123" }
    area_id { 1 }
    address { "address" }
    first_name {"firstname"}
    last_name {"lastname"}
    longitude { 1.5 }
    latitude { 1.5 }
    role {"admin"}
    confirmed_at { DateTime.now }
  end
end
