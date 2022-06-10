require 'rails_helper'

RSpec.describe "Donations", type: :request do

  # Get all donations
  describe "GET /donations" do

    before do
      @user = create(:user)
      sign_in @user
    end

    it "returns http success" do
      get "/donations"
      expect(response).to have_http_status(:success)
    end

    it "Returns json with items equal to count of all existing donations" do
      get "/donations"
      expect(response).to have_http_status(:success)
      donations = JSON.parse(response.body)
      expect(donations.count).to eq(Donation.all.count)
    end
  end

  # Show donation
  describe "POST /donation" do
    before do
      @user = create(:user)
      sign_in @user
    end

    id_to_request = 1

    let!(:donation_requested) {post "/donation", params: { id: id_to_request }}

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    
    it "Returns the json with id equal to parameter id passed" do
      donation = JSON.parse(response.body)
      expect(donation["id"]).to match(id_to_request)
    end
  end

  # Add donation
  describe "POST /donation" do
    before do
      @user = create(:user)
      sign_in @user
    end

    it "returns http success" do
       post "/add_donation", params: {donation: {
        user_id: 1,
        need_id: 1,
        amount: 500
      }}
      expect(response).to have_http_status(:success)
    end

    it "Will increase the count of donations" do
      expect {post "/add_donation", params: {donation: {
        user_id: 1,
        need_id: 1,
        amount: 500
      }}}. to \
      change(Donation, :count)
      .by(1)
    end
  end

  # Edit donation
  describe "POST /donation" do
    it "returns http success" do
      post "/edit_donation", params: {id: 1, donation: {
        user_id: 1,
        need_id: 1,
        amount: 500
      }} 
      expect(response).to have_http_status(:success)
    end
  end

  # Delete donation
  describe "DELETE /donation" do
    it "returns http success" do
      delete "/donation", params: {id: 2}
      expect(response).to have_http_status(:success)
    end
  end

end
