require 'rails_helper'

RSpec.describe "Messages", type: :request do

  # Get all messages
  describe "GET /messages" do
    before do
      @user = create(:user)
      @user.role = "user"
      sign_in @user
    end

    it "Returns http success" do
      get "/messages"
      expect(response).to have_http_status(:success)
    end

    it "Returns json with items equal to count of all existing messages" do
      get "/messages"
      expect(response).to have_http_status(:success)
      messages = JSON.parse(response.body)
      expect(messages.count).to eq(Message.all.count)
    end
  end

  # Show message
  describe "POST /message" do
    before do
      @user = create(:user)
      @user.role = "user"
      sign_in @user
    end

    id_to_request = 1

    let!(:message_requested) {post "/message", params: { id: id_to_request }}

    it "Returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "Returns the json with id equal to parameter id passed" do
      message = JSON.parse(response.body)
      expect(message["id"]).to match(id_to_request)
    end
  end

  # Add message
  describe "POST /add_message" do
    before do
      @user = create(:user)
      @user.role = "user"
      sign_in @user
    end

    it "Returns http success" do
      post "/add_message", params: { message: {
        sender_id: 1,
        receiver_id: 4,
        message_content: "help from user 1"
      }}
      expect(response).to have_http_status(:success)
    end

    it "Will increase the count of messages" do
      expect {post "/add_message", params: {message: {
        sender_id: 1,
        receiver_id: 4,
        message_content: "help from user 1"
      }}}. to \
      change(Message, :count)
      .by(1)
    end
  end

  # Edit message
  describe "POST /edit_message" do
    before do
      @user = create(:user)
      @user.role = "user"
      sign_in @user
    end

    it "Returns http success" do
      post "/edit_message", params: {id: 1, message: {
        sender_id: 1,
        receiver_id: 4,
        message_content: "help from user edited"
      }}
      expect(response).to have_http_status(:success)
    end

    it "Returns json with field equal to update value" do
      post "/edit_message", params: {id: 1, message: {
        sender_id: 1,
        receiver_id: 4,
        message_content: "help from user edited"
      }}
      message = JSON.parse(response.body)
      expect(message["message_content"]).to eq "help from user edited"
    end
  end

  # Delete message
  describe "DELETE /message" do
    before do
      @user = create(:user)
      @user.role = "user"
      sign_in @user
    end

    let!(:message) {Message.create!(
      sender_id: 1,
      receiver_id: 4,
      message_content: "help from user edited"
    )}

    it "Returns http success" do
      delete "/message", params: { id: message.id }
      expect(response).to have_http_status(:success)
    end

    it "Decreases the count of messages" do
      expect {delete "/message", params: {id: message.id}}. to \
      change(Message, :count)
      .by(-1)
    end
  end

end
