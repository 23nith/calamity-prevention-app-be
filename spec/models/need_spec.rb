require 'rails_helper'

RSpec.describe Need, type: :model do
  context "Validation" do
    let!(:need) {Need.new}

    it "1. is not valid without calamity_id" do
      need.cost = 100
      need.count = 3
      expect(need).to_not be_valid
    end

    it "2. is not valid without cost" do
      need.calamity_id = 1
      need.count = 3
      expect(need).to_not be_valid
    end

    it "3. is not valid if cost is not numerical" do
      need.calamity_id = 1
      need.cost = "string"
      need.count = 3
      expect(need).to_not be_valid
    end

    it "4. is not valid without count" do
      need.calamity_id = 1
      need.cost = 100
      expect(need).to_not be_valid
    end

    it "5. is not valid if count is not numerical" do
      need.calamity_id = 1
      need.cost = 100
      need.count = "string"
      expect(need).to_not be_valid
    end

  end

  context "Association" do

    it "1. should have many donations" do
      t = Area.reflect_on_association(:donations)
      expect(t.macro).to eq(:has_many)
    end

    it "1. should belong to calamity" do
      t = Area.reflect_on_association(:calamity)
      expect(t.macro).to eq(:belongs_to)
    end

  end

end
