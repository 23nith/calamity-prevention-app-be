require 'rails_helper'

RSpec.describe Calamity, type: :model do
  context "Validations" do
    let!(:area) {Area.create!(name: "Project 8", address: "Congressional Avenue", longitude: 1.5, latitude: 1.5, radius: 1.5)}
    let!(:calamity) {Calamity.new}

    it '1. is not valid without area id' do
      calamity.estimated_date_from = DateTime.now
      calamity.estimated_date_to = DateTime.now + 1
      calamity.calamity_type = "Flood"
      calamity.description = "Waist deep"
      expect(calamity).to_not be_valid
    end

    it '2. is not valid without estimated-date-from' do
      calamity.area_id = area.id
      calamity.estimated_date_to = DateTime.now + 1
      calamity.calamity_type = "Flood"
      calamity.description = "Waist deep"
      expect(calamity).to_not be_valid
    end

    it '3. is not valid without estimated-date-to' do
      calamity.area_id = area.id
      calamity.estimated_date_from = DateTime.now
      calamity.calamity_type = "Flood"
      calamity.description = "Waist deep"
      expect(calamity).to_not be_valid
    end

    it '4. is not valid if estimated-date-to is an earlier date from estimated-date-from' do
      calamity.area_id = area.id
      calamity.estimated_date_from = DateTime.now
      calamity.estimated_date_to = DateTime.now - 1
      calamity.calamity_type = "Flood"
      calamity.description = "Waist deep"
      expect(calamity).to_not be_valid
    end

    it '5. is not valid without calamity_type' do
      calamity.area_id = area.id
      calamity.estimated_date_from = DateTime.now
      calamity.estimated_date_to = DateTime.now + 1
      calamity.description = "Waist deep"
      expect(calamity).to_not be_valid
    end

    it '6. is not valid without description' do
      calamity.area_id = area.id
      calamity.estimated_date_from = DateTime.now
      calamity.estimated_date_to = DateTime.now + 1
      calamity.calamity_type = "Flood"
      expect(calamity).to_not be_valid
    end

    it '7. is not valid if description goes beyond 140 characters' do
      hundred_and_forty_chars_string = "jtlPG2S2v1sbqSA2WujlEFWSei1WC7Q1J8ILywfX2rQvpb4GdkGuWxYMmVsWrizz0OZbVI8VXv510okvo9qJljF4x7OEqa208b9ZzV3B0ykGbanrRL2Q9xSZ5Dhqe20jOm4Cc2p0IDVi" 
      calamity.area_id = area.id
      calamity.estimated_date_from = DateTime.now
      calamity.estimated_date_to = DateTime.now + 1
      calamity.calamity_type = "Flood"
      calamity.description = hundred_and_forty_chars_string + "1"
      expect(calamity).to_not be_valid
    end

    it '8. is valid if all fields are correct' do
      calamity.area_id = area.id
      calamity.estimated_date_from = DateTime.now
      calamity.estimated_date_to = DateTime.now + 1
      calamity.calamity_type = "Flood"
      calamity.description = "Waist deep"
      expect(calamity).to be_valid
    end

  end

  context "Association" do

    it "1. should have many needs" do
      t = Calamity.reflect_on_association(:needs)
      expect(t.macro).to eq(:has_many)
    end

    it "2. should belong to area" do
      t = Calamity.reflect_on_association(:area)
      expect(t.macro).to eq(:belongs_to)
    end

  end

end
