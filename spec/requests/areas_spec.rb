require 'rails_helper'

RSpec.describe "AreasController", type: :request do

  # Get all areas
  describe "GET /areas" do
    before do
      @user = create(:user)
      sign_in @user
    end

    it "Returns response 200" do
      get "/areas"
      expect(response).to have_http_status(:success)
    end

    it "Returns json with items equal to count of all existing Areas" do
      get '/areas'

      expect(response).to have_http_status(:success)
      areas = JSON.parse(response.body)
      expect(areas.count).to eq(Area.all.count)
    end
  end

  # Show area
  describe "POST /area" do
    before do
      @user = create(:user)
      sign_in @user
    end

    id_to_request = 1

    let!(:area_requested) {post "/area", params: {id: id_to_request}}
    

    it "Returns response 200" do
      expect(response).to have_http_status(:success)
    end

    it "Returns the json with id equal to parameter id passed" do
      area = JSON.parse(response.body)
      # debugger
      expect(area["id"]).to match(id_to_request)
    end
  end

  # Add area
  describe "POST /add_area" do

    context "Current user is admin" do
      before do
        @user = create(:user)
        @user.role = "admin"
        sign_in @user
      end

      it "Returns response successful" do 
        post "/add_area", params: {area: {address: "address", name: "name", longitude: 1.5, latitude: 1.5, radius: 1.5}}

        expect(response).to have_http_status(:success)
      end

      it "Will increase the count of areas" do
        expect {post "/add_area", params: {area: {address: "address", name: "name", longitude: 1.5, latitude: 1.5, radius: 1.5}}}. to \
      change(Area, :count)
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
        post "/add_area", params: {area: {address: "address", name: "name", longitude: 1.5, latitude: 1.5, radius: 1.5}}
        
        expect(response).to have_http_status(403)
      end
    end

    context "Fields are invalid" do
      before do
        @user = create(:user)
        @user.role = "admin"
        sign_in @user
      end

      
      it "Returns response 422" do
        post "/add_area", params: {area: {address: "address", name: "name", longitude: "string", latitude: 1.5, radius: 1.5}}
        expect(response).to have_http_status(422)
      end
    end
  end

  # Edit area
  describe "POST /edit_area" do
    context "Current user is admin" do
      before do
        @user = create(:user)
        sign_in @user
      end    

      it "Returns response successful" do 
        post "/edit_area", params:{id: 1, area: {address: "address", name: "edited_name", longitude: 1.5, latitude: 1.5, radius: 1.5}}

        expect(response).to have_http_status(:success)
      end

      it "Returns json with field equal to update value" do
        post "/edit_area", params:{id: 1, area: {address: "address", name: "edited_name", longitude: 1.5, latitude: 1.5, radius: 1.5}}
        area = JSON.parse(response.body)
        expect(area["name"]).to eq "edited_name"
      end
    end

    context "Current user is not admin" do
      before do
        @user = create(:user)
        @user.role = "user"
        sign_in @user
      end    

      it "Returns response 403" do
        post "/edit_area", params:{id: 1, area: {address: "address", name: "edited_name", longitude: 1.5, latitude: 1.5, radius: 1.5}}

        expect(response).to have_http_status(:forbidden)
      end
    end

    context "Fields are invalid" do
      before do
        @user = create(:user)
        sign_in @user
      end    

      it "Returns response 422" do
        post "/edit_area", params:{id: 1, area: {address: "address", name: "edited_name", longitude: "string", latitude: "string", radius: 1.5}}
        expect(response).to have_http_status(422)
      end
    end
  end

  # Delete area
  describe "DELETE /area" do

    context "Current user is admin" do
      before do
        @user = create(:user)
        sign_in @user
      end 

      let!(:area) {Area.create!(address: "address", name: "name", longitude: 1.5, latitude: 1.5, radius: 1.5)}

      it "Returns response successful" do 
        delete "/area", params:{id: area.id}
        expect(response).to have_http_status(:success)
      end

      let!(:area) {Area.create!(address: "address", name: "name", longitude: 1.5, latitude: 1.5, radius: 1.5)}

      it "Decreases the count of areas" do
        expect {delete "/area", params: {id: area.id}}. to \
      change(Area, :count)
      .by(-1)
      end
    end

    context "Current user is not admin" do
      before do
        @user = create(:user)
        @user.role = "user"
        sign_in @user
      end 
      it "Returns response 403" do
        delete "/area", params:{id: 1}
        expect(response).to have_http_status(403)
      end
    end

  end
end
