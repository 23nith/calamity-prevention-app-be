require 'rails_helper'

RSpec.describe User, type: :model do
  
  context "Validation" do
    let!(:user) {User.new}
    
    it "1. is not valid without area_id" do
      user.area_id = 1
      user.first_name = "firstName"
      user.last_name = "lastName"
      user.address = "Quezon City"
      user.longitude = 1.5
      user.latitude = 1.5
      user.role = "user"
      expect(user).to_not be_valid
    end

    it "2. is not valid without first name" do
      user.area_id = 1
      user.last_name = "lastName"
      user.address = "Quezon City"
      user.longitude = 1.5
      user.latitude = 1.5
      user.role = "user"
      expect(user).to_not be_valid
    end

    it "3. is not valid without last name" do
      user.area_id = 1
      user.first_name = "firstName"
      user.address = "Quezon City"
      user.longitude = 1.5
      user.latitude = 1.5
      user.role = "user"
      expect(user).to_not be_valid
    end

    it "4. is not valid without address" do
      user.area_id = 1
      user.first_name = "firstName"
      user.last_name = "lastName"
      user.longitude = 1.5
      user.latitude = 1.5
      user.role = "user"
      expect(user).to_not be_valid
    end

    it "5. is not valid if address goes beyond 200 characters" do
      two_hundred_chars_string = "tC7WhWynzvFsnWFgFoMTiVkvyRms7V2rZzUOemddg5XY961u3tDuDisAMNp6k8mDoKcjt9T4akB6uWZ6izOTFNqtXQvI2y4y429serBzba2Z49au9cHvtmEXkuesKnLcSPRggcYpoClxGmLaMWKSHkhzHvXbW0lCyI2vlyQXDmAGEamsKYef2OD4TaMTjvP9bVry64Iw"
      user.area_id = 1
      user.first_name = "firstName"
      user.last_name = "lastName"
      user.address = two_hundred_chars_string + "1"
      user.longitude = 1.5
      user.latitude = 1.5
      user.role = "user"
      expect(user).to_not be_valid
    end
    
    it "6. is not valid without longitude" do
      user.area_id = 1
      user.first_name = "firstName"
      user.last_name = "lastName"
      user.address = "Quezon City"
      user.latitude = 1.5
      user.role = "user"
      expect(user).to_not be_valid
    end
    
    it "7. is not valid if longitude is not numerical" do
      user.area_id = 1
      user.first_name = "firstName"
      user.last_name = "lastName"
      user.address = "Quezon City"
      user.longitude = "string"
      user.latitude = 1.5
      user.role = "user"
      expect(user).to_not be_valid
    end
    
    it "8. is not valid if latitude is not numerical" do
      user.area_id = 1
      user.first_name = "firstName"
      user.last_name = "lastName"
      user.address = "Quezon City"
      user.longitude = 1.5
      user.latitude = "string"
      user.role = "user"
      expect(user).to_not be_valid
    end
    
    it "9. is valid if all fields are correct" do
      user.area_id = 1
      user.first_name = "firstName"
      user.last_name = "lastName"
      user.address = "Quezon City"
      user.longitude = 1.5
      user.latitude = 1.5
      user.role = "user"
      expect(user).to_not be_valid
    end

  end

  context "Association" do

    it "1. should have many donations" do
      t = User.reflect_on_association(:donations)
      expect(t.macro).to eq(:has_many)
    end

    it "2. should belong to area" do
      t = User.reflect_on_association(:area)
      expect(t.macro).to eq(:belongs_to)
    end

  end

end