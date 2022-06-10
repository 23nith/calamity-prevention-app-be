require 'rails_helper'

RSpec.describe "Users", type: :request do
  
  # Get all users
  describe "GET /accounts" do
    context "Current user is admin" do
      before do
        @user = create(:user)
        sign_in @user
      end

      it "Returns http success" do
        get "/accounts"
        expect(response).to have_http_status(:success)
      end

      it "Returns json with items equal to count of all existing accounts" do
        get "/accounts"
        expect(response).to have_http_status(:success)
        users = JSON.parse(response.body)
        expect(users.count).to eq(User.all.count)
      end
    end

    context "Current user is not admin" do
      before do
        @user = create(:user)
        @user.role = "user"
        sign_in @user
      end

      it "Returns response 403" do
        get "/accounts"
        expect(response).to have_http_status(403)
      end
    end
  end

  # Show user
  describe "POST /account" do
    id_to_request = 1

    let!(:user_requested) {post "/account", params: { id: id_to_request }}

    it "Returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "Returns the json with id equal to parameter id passed" do
      user = JSON.parse(response.body)
      expect(user["id"]).to match(id_to_request)
    end
  end

  # Add user
  describe "POST /add_account" do
    context "Current user is admin" do
      before do
        @user = create(:user)
        sign_in @user
      end

      it "Returns http success" do
        post "/add_account", params: {"user": {
          "email": "test123@email.com",
          "password": "password",
          "area_id": 1,
          "address": "test address",
          "first_name": "test firstname",
          "last_name": "test lastname",
          "longitude": 1.5,
          "latitude": 1.5,
          "role": "contact_person"
        }}
        expect(response).to have_http_status(:success)
      end

      it "Will increase the count of users" do
        expect {post "/add_account", params: {"user": {
          "email": "test123@email.com",
          "password": "password",
          "area_id": 1,
          "address": "test address",
          "first_name": "test firstname",
          "last_name": "test lastname",
          "longitude": 1.5,
          "latitude": 1.5,
          "role": "contact_person"
        }}}. to \
        change(User, :count)
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
        post "/add_account", params: {"user": {
          "email": "test123@email.com",
          "password": "password",
          "area_id": 1,
          "address": "test address",
          "first_name": "test firstname",
          "last_name": "test lastname",
          "longitude": 1.5,
          "latitude": 1.5,
          "role": "contact_person"
        }}
        expect(response).to have_http_status(403)
      end
    end

    context "Created account is of the role 'contact_person'" do
      before do
        @user = create(:user)
        sign_in @user
      end 
      it "Will increase the count of ContactPerson" do
        expect {post "/add_account", params: {"user": {
          "email": "test123@email.com",
          "password": "password",
          "area_id": 1,
          "address": "test address",
          "first_name": "test firstname",
          "last_name": "test lastname",
          "longitude": 1.5,
          "latitude": 1.5,
          "role": "contact_person"
        }}}. to \
        change(ContactPerson, :count)
        .by(1)
      end
    end

    context "Created account is of the role 'admin'" do
      before do
        @user = create(:user)
        sign_in @user
      end 
      it "Will increase the count of Admin" do
        expect {post "/add_account", params: {"user": {
          "email": "test123@email.com",
          "password": "password",
          "area_id": 1,
          "address": "test address",
          "first_name": "test firstname",
          "last_name": "test lastname",
          "longitude": 1.5,
          "latitude": 1.5,
          "role": "admin"
        }}}. to \
        change(Admin, :count)
        .by(1)
      end
    end
  end

  # Edit user
  describe "POST /edit_account" do
    context "Current user is admin" do
      before do
        @user = create(:user)
        sign_in @user
      end
      it "Returns http success" do
        post "/edit_account", params: {id: 1, "user": {
          "email": "test123@email.com",
          "password": "password",
          "area_id": 1,
          "address": "test address",
          "first_name": "test firstname edited",
          "last_name": "test lastname",
          "longitude": 1.5,
          "latitude": 1.5,
          "role": "contact_person"
        }}
        expect(response).to have_http_status(:success)
      end

      it "Returns json with field equal to update value" do
        post "/edit_account", params: {id: 1, "user": {
          "email": "test123@email.com",
          "password": "password",
          "area_id": 1,
          "address": "test address",
          "first_name": "test firstname edited",
          "last_name": "test lastname",
          "longitude": 1.5,
          "latitude": 1.5,
          "role": "contact_person"
        }}
        user = JSON.parse(response.body)
        expect(user["first_name"]).to eq "test firstname edited"
      end
    end

    context "Current user is not admin" do
      before do
        @user = create(:user)
        @user.role = "user"
        sign_in @user
      end
      it "Returns response 403" do
        post "/edit_account", params: {id: 1, "user": {
          "email": "test123@email.com",
          "password": "password",
          "area_id": 1,
          "address": "test address",
          "first_name": "test firstname edited",
          "last_name": "test lastname",
          "longitude": 1.5,
          "latitude": 1.5,
          "role": "contact_person"
        }}
        expect(response).to have_http_status(403)
      end
    end

  end

  # Delete user
  describe "DELETE /account" do

    context "Current user is admin" do
      before do
        @user = create(:user)
        sign_in @user
      end 

      let!(:user) {User.create!(
        email: "test123@email.com",
        password: "password",
        area_id: 1,
        address: "test address",
        first_name: "test firstname",
        last_name: "test lastname",
        longitude: 1.5,
        latitude: 1.5,
        role: "contact_person"
      )}

      it "Returns response successful" do 
        delete "/account", params:{id: user.id}
        expect(response).to have_http_status(:success)
      end

      let!(:user) {User.create!(
        email: "test123@email.com",
        password: "password",
        area_id: 1,
        address: "test address",
        first_name: "test firstname",
        last_name: "test lastname",
        longitude: 1.5,
        latitude: 1.5,
        role: "contact_person"
      )}

      it "Decreases the count of areas" do
        expect {delete "/account", params: {id: user.id}}. to \
      change(User, :count)
      .by(-1)
      end
    end

    context "Current user is admin" do
      before do
        @user = create(:user)
        @user.role = "user"
        sign_in @user
      end 

      let!(:user) {User.create!(
        email: "test123@email.com",
        password: "password",
        area_id: 1,
        address: "test address",
        first_name: "test firstname",
        last_name: "test lastname",
        longitude: 1.5,
        latitude: 1.5,
        role: "contact_person"
      )}

      it "Returns response 403" do
        delete "/account", params:{id: user.id}
        expect(response).to have_http_status(403)
      end
    end
  end

end
