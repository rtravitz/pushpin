require "rails_helper"

describe "message_sender" do
  context "#send_code" do
    it "sends a user a code" do
      code = CodeGenerator.generate
      MessageSender.send_code(ENV["twilio_number"], code)
    end
  end
end
