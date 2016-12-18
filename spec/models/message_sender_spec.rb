require "rails_helper"

describe "message_sender" do
  context "#send_code" do
    it "sends a user a code" do
      code = CodeGenerator.generate
      message = MessageSender.send_code(ENV["twilio_number"], code)
      
      expect(message).to be_truthy
    end
  end
end
