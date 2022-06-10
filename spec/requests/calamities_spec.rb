require 'rails_helper'

RSpec.describe "Calamities", type: :request do

  # Get all calamities
  describe "GET /calamities" do
    before do
      @user = create(:user)
      sign_in @user
    end

    it "Returns http success" do
      get "/calamities"
      expect(response).to have_http_status(:success)
    end

    it "Returns json with items equal to count of all existing calamities" do
      get "/calamities"
      expect(response).to have_http_status(:success)
      calamities = JSON.parse(response.body)
      expect(calamities.count).to eq(Calamity.all.count)
    end
  end

  # Show calamity
  describe "POST /calamity" do
    before do
      @user = create(:user)
      sign_in @user
    end

    id_to_request = 1

    let!(:calamity_requested) {post "/calamity", params: { id: id_to_request }}

    it "Returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "Returns the json with id equal to parameter id passed" do
      calamity = JSON.parse(response.body)
      expect(calamity["id"]).to match(id_to_request)
    end
  end

  # Add calamity
  describe "POST /add_calamity" do
    context "Current user is admin" do
      before do
        @user = create(:user)
        sign_in @user
      end

      it "Returns http success" do
        post "/add_calamity", params: {calamity: {estimated_date_from: "Fri Jun 10 2022 11:53:50 GMT+0000", estimated_date_to: "Sat Jun 11 2022 11:53:50 GMT+0000", description: "test description", calamity_type: "test calamity type", area_id: 1}}
        expect(response).to have_http_status(:success)
      end

      it "Will increase the count of calamities" do
        expect {post "/add_calamity", params: {calamity: {estimated_date_from: "Fri Jun 10 2022 11:53:50 GMT+0000", estimated_date_to: "Sat Jun 11 2022 11:53:50 GMT+0000", description: "test description", calamity_type: "test calamity type", area_id: 1}}}. to \
        change(Calamity, :count)
        .by(1)
      end
    end

    context "Current user is not admin" do
      before do 
        @user = create(:user)
        @user.role = "user"
        sign_in @user
      end

      it "Returns response 403" do
        post "/add_calamity", params: {calamity: {estimated_date_from: "Fri Jun 10 2022 11:53:50 GMT+0000", estimated_date_to: "Sat Jun 11 2022 11:53:50 GMT+0000", description: "test description", calamity_type: "test calamity type", area_id: 1}}
        expect(response).to have_http_status(403)
      end
    end
  end

  # Edit calamity
  describe "POST /edit_calamity" do
    context "Current user is admin" do
      before do
        @user = create(:user)
        sign_in @user
      end

      it "Returns http success" do
        post "/edit_calamity", params: {id: 1, calamity: {estimated_date_from: "Fri Jun 10 2022 11:53:50 GMT+0000", estimated_date_to: "Sat Jun 11 2022 11:53:50 GMT+0000", description: "test description", calamity_type: "test calamity type", area_id: 1}}
        expect(response).to have_http_status(:success)
      end

      it "Returns json with field equal to update value" do
        post "/edit_calamity", params: {id: 1, calamity: {estimated_date_from: "Fri Jun 10 2022 11:53:50 GMT+0000", estimated_date_to: "Sat Jun 11 2022 11:53:50 GMT+0000", description: "test description", calamity_type: "edited test calamity type", area_id: 1}}
        calamity = JSON.parse(response.body)
        expect(calamity["calamity_type"]).to eq "edited test calamity type"
      end
    end

    context "Current user is not admin" do
      before do 
        @user = create(:user)
        @user.role = "user"
        sign_in @user
      end

      it "Returns response 403" do
        post "/edit_calamity", params: {id: 1, calamity: {estimated_date_from: "Fri Jun 10 2022 11:53:50 GMT+0000", estimated_date_to: "Sat Jun 11 2022 11:53:50 GMT+0000", description: "test description", calamity_type: "test calamity type", area_id: 1}}
        expect(response).to have_http_status(403)
      end
    end
  end

  # Delete calamity
  describe "DELETE /calamity" do
    context "Current user is admin" do
      before do
        @user = create(:user)
        sign_in @user
      end

      let!(:calamity) {Calamity.create!(estimated_date_from: "Fri Jun 10 2022 11:53:50 GMT+0000", estimated_date_to: "Sat Jun 11 2022 11:53:50 GMT+0000", description: "test description", calamity_type: "test calamity type", area_id: 1)}

      it "Returns http success" do
        delete "/calamity", params: {id: calamity.id}
        expect(response).to have_http_status(:success)
      end

      it "Decreases the count of areas" do
        expect {delete "/calamity", params: {id: calamity.id}}. to \
        change(Calamity, :count)
        .by(-1)
      end

    end

    context "Current user is not admin" do
      before do
        @user = create(:user)
        @user.role = "user"
        sign_in @user
      end

      let!(:calamity) {Calamity.create!(estimated_date_from: "Fri Jun 10 2022 11:53:50 GMT+0000", estimated_date_to: "Sat Jun 11 2022 11:53:50 GMT+0000", description: "test description", calamity_type: "test calamity type", area_id: 1)}

      it "Returns response 403" do
        delete "/calamity", params: {id: calamity.id}
        expect(response).to have_http_status(403)
      end
    end
  end
end
