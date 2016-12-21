require "rails_helper"

describe "ConfirmationSender" do
  context "#send_confirmation_to" do
    it "initiates gives a user a verification code" do
      user = create(:user, phone: ENV["twilio_number"])

      expect(user.verification_code).to eq(nil)
      ConfirmationSender.send_confirmation_to(user)

      expect(user.verification_code).to_not eq(nil)
    end
  end
end
