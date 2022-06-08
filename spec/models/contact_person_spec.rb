require 'rails_helper'

RSpec.describe ContactPerson, type: :model do
  
  context "Validation" do
    let!(:contact_person) {ContactPerson.new}

    it "1. is not valid without area_id" do
      contact_person.user_id = 1
      expect(contact_person).to_not be_valid
    end

    it "2. is not valid without user_id" do
      contact_person.area_id = 1
      expect(contact_person).to_not be_valid
    end

  end
end
