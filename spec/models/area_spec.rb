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

    it '3. is not valid without longitude' do
      area.name = "Project 8"
      area.address = "Congressional Avenue"
      area.latitude = 1.5
      area.radius = 1.5
      expect(area).to_not be_valid
    end

    it '4. is not valid without latitude' do
      area.name = "Project 8"
      area.address = "Congressional Avenue"
      area.longitude = 1.5
      area.radius = 1.5
      expect(area).to_not be_valid
    end

    it '5. is not valid without radius' do
      area.name = "Project 8"
      area.address = "Congressional Avenue"
      area.longitude = 1.5
      area.latitude = 1.5
      expect(area).to_not be_valid
    end

  end

  context "Association" do

    it "should have many users" do
      t = Area.reflect_on_association(:users)
      expect(t.macro).to eq(:has_many)
    end

    it "should have many calamities" do
      t = Area.reflect_on_association(:calamities)
      expect(t.macro).to eq(:has_many)
    end

    it "should have one contact person" do
      t = Area.reflect_on_association(:contact_person)
      expect(t.macro).to eq(:has_one)
    end

  end
end
