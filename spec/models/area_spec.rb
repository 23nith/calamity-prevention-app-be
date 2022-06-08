require 'rails_helper'

RSpec.describe Area, type: :model do
  context "Validations" do
    let!(:area) { Area.new }

    it '1. is not valid without name' do
      area.address = "Congressional Avenue"
      area.longitude = 1.5
      area.latitude = 1.5
      area.radius = 1.5
      expect(area).to_not be_valid
    end

    it '2. is not valid without address' do
      area.name = "Project 8"
      area.longitude = 1.5
      area.latitude = 1.5
      area.radius = 1.5
      expect(area).to_not be_valid
    end

    
    it "3. is not valid if address goes beyond 200 characters" do
      two_hundred_chars_string = "tC7WhWynzvFsnWFgFoMTiVkvyRms7V2rZzUOemddg5XY961u3tDuDisAMNp6k8mDoKcjt9T4akB6uWZ6izOTFNqtXQvI2y4y429serBzba2Z49au9cHvtmEXkuesKnLcSPRggcYpoClxGmLaMWKSHkhzHvXbW0lCyI2vlyQXDmAGEamsKYef2OD4TaMTjvP9bVry64Iw"
      area.address = two_hundred_chars_string + "1"
      area.name = "Project 8"
      area.longitude = 1.5
      area.latitude = 1.5
      area.radius = 1.5
      expect(area).to_not be_valid
    end

    it '4. is not valid without longitude' do
      area.name = "Project 8"
      area.address = "Congressional Avenue"
      area.latitude = 1.5
      area.radius = 1.5
      expect(area).to_not be_valid
    end

    it '5. is not valid without latitude' do
      area.name = "Project 8"
      area.address = "Congressional Avenue"
      area.longitude = 1.5
      area.radius = 1.5
      expect(area).to_not be_valid
    end

    it '6. is not valid without radius' do
      area.name = "Project 8"
      area.address = "Congressional Avenue"
      area.longitude = 1.5
      area.latitude = 1.5
      expect(area).to_not be_valid
    end

    it '7. is not valid if longitude is not numerical' do
      area.name = "Project 8"
      area.address = "Congressional Avenue"
      area.longitude = "string"
      area.latitude = 1.5
      area.radius = 1.5
      expect(area).to_not be_valid
    end

    it '8. is not valid if latitude is not numerical' do
      area.name = "Project 8"
      area.address = "Congressional Avenue"
      area.longitude = 1.5
      area.latitude = "string"
      area.radius = 1.5
      expect(area).to_not be_valid
    end

    it '9. is not valid if radius is not numerical' do
      area.name = "Project 8"
      area.address = "Congressional Avenue"
      area.longitude = 1.5
      area.latitude = 1.5
      area.radius = "string"
      expect(area).to_not be_valid
    end

  end

  context "Association" do

    it "1. should have many users" do
      t = Area.reflect_on_association(:users)
      expect(t.macro).to eq(:has_many)
    end

    it "2. should have many calamities" do
      t = Area.reflect_on_association(:calamities)
      expect(t.macro).to eq(:has_many)
    end

    it "3. should have one contact people" do
      t = Area.reflect_on_association(:contact_people)
      expect(t.macro).to eq(:has_one)
    end

  end
end
