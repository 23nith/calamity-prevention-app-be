require 'rails_helper'

RSpec.describe User, type: :model do
  
  context "Validation" do
    let!(:user) {User.new}
    
    it "1. is not valid without area_id" do
      user.first_name = "firstName"
      user.last_name = "lastName"
      user.address = "Quezon City"
      expect(user).to_not be_valid
    end

    it "2. is not valid without first name" do
      user.area_id = 1
      user.last_name = "lastName"
      user.address = "Quezon City"
      expect(user).to_not be_valid
    end

    it "3. is not valid without last name" do
      user.area_id = 1
      user.first_name = "firstName"
      user.address = "Quezon City"
      expect(user).to_not be_valid
    end

    it "4. is not valid without address" do
      user.area_id = 1
      user.first_name = "firstName"
      user.last_name = "lastName"
      expect(user).to_not be_valid
    end

    it "5. is not valid if address goes beyond 200 characters" do
      two_hundred_chars_string = "tC7WhWynzvFsnWFgFoMTiVkvyRms7V2rZzUOemddg5XY961u3tDuDisAMNp6k8mDoKcjt9T4akB6uWZ6izOTFNqtXQvI2y4y429serBzba2Z49au9cHvtmEXkuesKnLcSPRggcYpoClxGmLaMWKSHkhzHvXbW0lCyI2vlyQXDmAGEamsKYef2OD4TaMTjvP9bVry64Iw"
      user.area_id = 1
      user.first_name = "firstName"
      user.last_name = "lastName"
      user.address = two_hundred_chars_string + "1"
      expect(user).to_not be_valid
    end

  end

  context "Association" do

    it "should have many donations" do
      t = Calamity.reflect_on_association(:donations)
      expect(t.macro).to eq(:has_many)
    end

    it "should belong to area" do
      t = Calamity.reflect_on_association(:area)
      expect(t.macro).to eq(:belongs_to)
    end

  end

end