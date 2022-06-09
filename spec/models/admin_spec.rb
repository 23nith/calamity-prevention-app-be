require 'rails_helper'

RSpec.describe Admin, type: :model do
  context "Validation" do
    let!(:area) {Area.create!(name: "Quezon City", address: "Congressional Ave", longitude: 1.5, latitude: 1.5, radius: 1.5)}
    let!(:user) {User.create!(email: "test@email.com", password: "password", first_name: "firstname", last_name: "lastname", address: "Quezon City", longitude: 1.5, latitude: 1.5, role: "user", area_id: area.id)}
    let!(:admin) {Admin.new}

    it "1. is not valid without user_id" do
      expect(admin).to_not be_valid
    end
    
    it "2. is valid if there is user_id" do
      admin.user_id = user.id
      expect(admin).to_not be_valid
    end

  end

end