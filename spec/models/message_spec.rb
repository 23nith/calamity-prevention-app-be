require 'rails_helper'

RSpec.describe Message, type: :model do
  context "Validation" do
    let!(:message) {Message.new}

    it "1. is not valid without sender_id" do 
      message.receiver_id = 1
      message_content = "Help"
      expect(message).to_not be_valid
    end

    it "2. is not valid without receiver_id" do 
      message.sender_id = 1
      message_content = "Help"
      expect(message).to_not be_valid
    end

    it "3. is not valid without message_content" do 
      message.sender_id = 1
      message.receiver_id = 1
      expect(message).to_not be_valid
    end

    it "4. is not valid if message_content goes beyond 140 characters" do 
      hundred_and_forty_chars_string = "jtlPG2S2v1sbqSA2WujlEFWSei1WC7Q1J8ILywfX2rQvpb4GdkGuWxYMmVsWrizz0OZbVI8VXv510okvo9qJljF4x7OEqa208b9ZzV3B0ykGbanrRL2Q9xSZ5Dhqe20jOm4Cc2p0IDVi" 
      message.sender_id = 1
      message.receiver_id = 1
      message_content = hundred_and_forty_chars_string + "1"
      expect(message).to_not be_valid
    end

  end
end
