require 'rails_helper'

RSpec.describe Need, type: :model do
  context "Validation" do
    let!(:need) {Need.new}

    it "1. is not valid without calamity_id" do
      need.cost = 100
      need.count = 3
      need.description = "Rescue boats"
      expect(need).to_not be_valid
    end

    it "2. is not valid without cost" do
      need.calamity_id = 1
      need.count = 3
      need.description = "Rescue boats"
      expect(need).to_not be_valid
    end

    it "3. is not valid if cost is not numerical" do
      need.calamity_id = 1
      need.cost = "string"
      need.count = 3
      need.description = "Rescue boats"
      expect(need).to_not be_valid
    end

    it "4. is not valid without count" do
      need.calamity_id = 1
      need.cost = 100
      need.description = "Rescue boats"
      expect(need).to_not be_valid
    end

    it "5. is not valid if count is not numerical" do
      need.calamity_id = 1
      need.cost = 100
      need.count = "string"
      need.description = "Rescue boats"
      expect(need).to_not be_valid
    end

    it "6. is not valid without description" do
      need.calamity_id = 1
      need.cost = 100
      need.count = "string"
      expect(need).to_not be_valid
    end

    it "7. is not valid if description goes beyond 140 characters" do
      hundred_and_forty_chars_string = "jtlPG2S2v1sbqSA2WujlEFWSei1WC7Q1J8ILywfX2rQvpb4GdkGuWxYMmVsWrizz0OZbVI8VXv510okvo9qJljF4x7OEqa208b9ZzV3B0ykGbanrRL2Q9xSZ5Dhqe20jOm4Cc2p0IDVi" 
      need.calamity_id = 1
      need.cost = 100
      need.count = "string"
      need.description = hundred_and_forty_chars_string + "1"
      expect(need).to_not be_valid
    end

  end

  context "Association" do

    it "1. should have many donations" do
      t = Area.reflect_on_association(:donations)
      expect(t.macro).to eq(:has_many)
    end

    it "2. should belong to calamity" do
      t = Area.reflect_on_association(:calamity)
      expect(t.macro).to eq(:belongs_to)
    end

  end

end
