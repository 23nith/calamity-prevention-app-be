require 'rails_helper'

RSpec.describe Donation, type: :model do
  context "Validation" do
    let!(:area) {Area.create!(name: "Quezon City", address: "Congressional Ave", longitude: 1.5, latitude: 1.5, radius: 1.5)}
    let!(:user) {User.create!(email: "test@email.com", password: "password", first_name: "firstname", last_name: "lastname", address: "Quezon City", longitude: 1.5, latitude: 1.5, role: "user", area_id: area.id)}
    let!(:donation) {Donation.new}
    

    it "1. is not valid without user_id" do
      donation.need_id = 1
      donation.amount = 100
      expect(donation).to_not be_valid
    end

    it "2. is not valid without need_id" do
      donation.user_id = user.id
      donation.amount = 100
      expect(donation).to_not be_valid
    end

    it "3. is not valid without amount" do
      donation.user_id = user.id
      donation.need_id = 1
      expect(donation).to_not be_valid
    end

    it "4. is not valid if amount is not numerical" do
      donation.user_id = user.id
      donation.need_id = 1
      donation.amount = "string"
      expect(donation).to_not be_valid
    end

    it "5. is not valid if amount is nil" do
      donation.user_id = user.id
      donation.need_id = 1
      donation.amount = 0
      expect(donation).to_not be_valid
    end

    it "6. is not valid if amount is negative" do
      donation.user_id = user.id
      donation.need_id = 1
      donation.amount = -5
      expect(donation).to_not be_valid
    end

    it "7. is valid if all fields are correct" do
      donation.user_id = user.id
      donation.need_id = 1
      donation.amount = 100
      expect(donation).to be_valid
    end

  end

  context "Association" do

    it "1. should have one" do
      t = Donation.reflect_on_association(:need)
      expect(t.macro).to eq(:has_one)
    end

    it "2. should belong to user" do
      t = Donation.reflect_on_association(:user)
      expect(t.macro).to eq(:belongs_to)
    end

  end

end
