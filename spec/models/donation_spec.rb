require 'rails_helper'

RSpec.describe Donation, type: :model do
  context "Validation" do
    let!(:donation) {Donation.new}

    it "1. is not valid without user_id" do
      donation.need_id = 1
      donation.amount = 100
      expect(donation).to_not be_valid
    end

    it "2. is not valid without need_id" do
      donation.user_id = 1
      donation.amount = 100
      expect(donation).to_not be_valid
    end

    it "3. is not valid without amount" do
      donation.user_id = 1
      donation.need_id = 1
      expect(donation).to_not be_valid
    end

    it "4. is not valid if amount is not numerical" do
      donation.user_id = 1
      donation.need_id = 1
      donation.amount = "string"
      expect(donation).to_not be_valid
    end

  end
end
