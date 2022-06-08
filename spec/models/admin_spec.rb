require 'rails_helper'

RSpec.describe Admin, type: :model do
  context "Validation" do
    let!(:admin) {Admin.new}

    it "1. is not valid without user_id" do
      admin.area_id = 1
      expect(admin).to_not be_valid
    end

  end

end