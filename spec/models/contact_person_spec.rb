require 'rails_helper'

RSpec.describe ContactPerson, type: :model do
    
  context "Validation" do
    let!(:area) {Area.create!(name: "Quezon City", address: "Congressional Ave", longitude: 1.5, latitude: 1.5, radius: 1.5)}
    let!(:user) {User.create!(email: "test@email.com", password: "password", first_name: "firstname", last_name: "lastname", address: "Quezon City", longitude: 1.5, latitude: 1.5, role: "user", area_id: area.id)}
    let!(:contact_person) {ContactPerson.new}
    
    it "1. is not valid without area_id" do
      contact_person.user_id = user.id
      expect(contact_person).to_not be_valid
    end

    it "2. is not valid without user_id" do
      contact_person.area_id = user.id
      expect(contact_person).to_not be_valid
    end

    it "3. is valid if all fields are present" do
      contact_person.user_id = user.id
      contact_person.area_id = area.id
      expect(contact_person).to be_valid
    end

  end

  context "Association" do

    it "1. should belong to area" do
      t = ContactPerson.reflect_on_association(:area)
      expect(t.macro).to eq(:belongs_to)
    end

  end

end
