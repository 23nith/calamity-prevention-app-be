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
end
