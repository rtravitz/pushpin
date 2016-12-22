require "rails_helper"

describe "messages endpoints" do
  context "GET /messages" do
    let(:user_r)          { create(:user) }
    let(:user_p)          { create(:user)}
    let(:requester)       { create(:role, title: "requester") }
    let(:professional)    { create(:role, title: "professional") }
    let(:project)         { create(:project, user: user_r) }
    let(:proposal)        { create(:proposal, user: user_p, project: project) }

    it "returns a list of messages for the api user" do
      user_r.roles << requester
      user_p.roles << professional
      message1 = proposal.messages.create(body: "test body", user: user_r)
      message2 = proposal.messages.create(body: "test body", user: user_p)

      get "/api/v1/messages?api_key=#{user_r.api_key}&proposal=#{proposal.id}"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result.count).to eq(2)

      expect(result[0]['user_id']).to eq(message2.user.id)
      expect(result[0]['body']).to eq(message2.body)
      expect(result[0]['proposal_id']).to eq(message2.proposal_id)

      expect(result[1]['user_id']).to eq(message1.user.id)
      expect(result[1]['body']).to eq(message1.body)
      expect(result[0]['proposal_id']).to eq(message1.proposal_id)
    end

    it "does not return messages for invalid api key" do
      user_r.roles << requester
      user_p.roles << professional
      message1 = proposal.messages.create(body: "test body", user: user_r)
      message2 = proposal.messages.create(body: "test body", user: user_p)
      invalid_api_key = "5"

      get "/api/v1/messages?api_key=#{invalid_api_key}&proposal=#{proposal.id}"

      parsed = JSON.parse(response.body)

      expect(parsed["message"]).to eq("You are not authorized!")
      expect(response).to have_http_status(403)
    end
  end

  context "POST /messages" do
    let(:user_r)          { create(:user) }
    let(:user_p)          { create(:user)}
    let(:requester)       { create(:role, title: "requester") }
    let(:professional)    { create(:role, title: "professional") }
    let(:project)         { create(:project, user: user_r) }
    let(:proposal)        { create(:proposal, user: user_p, project: project) }

    it "creates a message for the api user" do
      user_r.roles << requester
      user_p.roles << professional

      message_body = "Test message"
      file = "http://picture.jpg"
      headers = { "CONTENT-TYPE" => "application/json" }
      body = { message: { body: message_body, image_url: file } }.to_json

      post "/api/v1/messages?api_key=#{user_r.api_key}&proposal=#{proposal.id}", body, headers

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(Message.last.body).to eq(message_body)
      expect(result['body']).to eq(message_body)
      expect(result['image_url']).to eq(file)
      expect(result['user_id']).to eq(user_r.id)
      expect(result['proposal_id']).to eq(proposal.id)
    end

    it "does not create a message for invalid api key" do
      user_r.roles << requester
      user_p.roles << professional

      message_body = "Test message"
      file = "http://picture.jpg"
      headers = { "CONTENT-TYPE" => "application/json" }
      body = { message: { body: message_body, image_url: file } }.to_json
      invalid_api_key = "5"

      post "/api/v1/messages?api_key=#{invalid_api_key}&proposal=#{proposal.id}", body, headers

      parsed = JSON.parse(response.body)

      expect(Message.last).to eq(nil)
      expect(parsed["message"]).to eq("You are not authorized!")
      expect(response).to have_http_status(403)
    end
  end
end
