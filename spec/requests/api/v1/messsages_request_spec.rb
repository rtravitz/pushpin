require "rails_helper"

describe "messages endpoints" do
  context "GET /messages" do
    it "returns a list of messages" do
      user_r, user_p = create_list(:user, 2)
      requester = create(:role, title: "requester")
      professional = create(:role, title: "professional")
      user_r.roles << requester
      user_p.roles << professional
      project = create(:project, user: user_r)
      proposal = create(:proposal, user: user_p, project: project)
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
  end
end
