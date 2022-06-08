require 'rails_helper'

RSpec.describe ContactPerson, type: :model do
  
  context "Validation" do
    let!(:contact_person) {ContactPerson.new}

    it "1. is not valid without area_id" do
      contact_person.area_id = 1
      contact_person.first_name = "firstName"
      contact_person.last_name = "lastName"
      contact_person.address = "Quezon City"
      expect(contact_person).to_not be_valid
    end

    it "2. is not valid without first name" do
      contact_person.area_id = 1
      contact_person.last_name = "lastName"
      contact_person.address = "Quezon City"
      expect(contact_person).to_not be_valid
    end

    it "3. is not valid without last name" do
      contact_person.area_id = 1
      contact_person.first_name = "firstName"
      contact_person.address = "Quezon City"
      expect(contact_person).to_not be_valid
    end

    it "4. is not valid without address" do
      contact_person.area_id = 1
      contact_person.first_name = "firstName"
      contact_person.last_name = "lastName"
      expect(contact_person).to_not be_valid
    end

    it "5. is not valid if address goes beyond 200 characters" do
      two_hundred_chars_string = "tC7WhWynzvFsnWFgFoMTiVkvyRms7V2rZzUOemddg5XY961u3tDuDisAMNp6k8mDoKcjt9T4akB6uWZ6izOTFNqtXQvI2y4y429serBzba2Z49au9cHvtmEXkuesKnLcSPRggcYpoClxGmLaMWKSHkhzHvXbW0lCyI2vlyQXDmAGEamsKYef2OD4TaMTjvP9bVry64Iw"
      contact_person.area_id = 1
      contact_person.first_name = "firstName"
      contact_person.last_name = "lastName"
      contact_person.address = two_hundred_chars_string + "1"
      expect(contact_person).to_not be_valid
    end

  end
end
