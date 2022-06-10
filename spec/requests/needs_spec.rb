require 'rails_helper'

RSpec.describe "Needs", type: :request do
  
  #Get all needs
  describe "GET /needs" do

    before do
      @user = create(:user)
      sign_in @user
    end

    it "Returns http success" do
      get "/needs"
      expect(response).to have_http_status(:success)
    end

    it "Returns json with items equal to count of all existing needs" do
      get "/needs"
      expect(response).to have_http_status(:success)
      needs = JSON.parse(response.body)
      expect(needs.count).to eq(Need.all.count)
    end
  end

  # Show need
  describe "POST /need" do
    before do
      @user = create(:user)
      sign_in @user
    end

    id_to_request = 1

    let!(:need_requested) {post "/need", params: { id: id_to_request }}

    it "Returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "Returns the json with id equal to parameter id passed" do
      need = JSON.parse(response.body)
      expect(need["id"]).to match(id_to_request)
    end
  end

  # Add need
  describe "POST /add_need" do
    before do
      @user = create(:user)
      sign_in @user
    end

    it "Returns http success" do
      post "/add_need", params: {need: {
        calamity_id: 1,
        cost: 50,
        count: 1,
        description: "test description"
      }}
      expect(response).to have_http_status(:success)
    end

    it "Will increase the count of needs" do
      expect {post "/add_need", params: {need: {
        calamity_id: 1,
        cost: 50,
        count: 1,
        description: "test description"
      }}}. to \
      change(Need, :count)
      .by(1)
    end
  end

  # Edit need
  describe "POST /edit_need" do
    before do
      @user = create(:user)
      sign_in @user
    end

    it "Returns http success" do
      post "/edit_need", params: {id: 1, need: {
        calamity_id: 1,
        cost: 50,
        count: 1,
        description: "test description edited"
      }}
      expect(response).to have_http_status(:success)
    end

    it "Returns json with field equal to update value" do
      post "/edit_need", params: {id: 1, need: {
        calamity_id: 1,
        cost: 50,
        count: 1,
        description: "test description edited"
      }}
      need = JSON.parse(response.body)
      expect(need["description"]).to eq "test description edited"
    end
  end

  # Delete need
  describe "DELETE /need" do
    before do
      @user = create(:user)
      sign_in @user
    end

    let!(:need) {Need.create!(
      calamity_id: 1,
      cost: 50,
      count: 1,
      description: "test description"
    )}

    it "Returns http success" do
      delete "/need", params: { id: need.id }
      expect(response).to have_http_status(:success)
    end

    it "Decreases the count of needs" do
      expect {delete "/need", params: {id: need.id}}. to \
      change(Need, :count)
      .by(-1)
    end

  end

end
