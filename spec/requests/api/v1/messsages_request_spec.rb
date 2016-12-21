require "rails_helper"

describe "messages endpoints" do
  context "GET /messages" do
    it "returns a list of messages" do
      user_r, user_p = create_list(:user, 2)
      requester = create(:role, title: "requester")
      professional = create(:role, title: "professional")
      user_r.roles << requester
      user_p.roles << professional
      project = create(:project, user: user1)
      proposal = create(:proposal, user: user2, project: project)
      message = proposal.messages.create(body: "test body", user: user_r)
      message = proposal.messages.create(body: "test body", user: user_p)

      get "/api/v1/messages?api_key=#{user_r.api_key}&proposal=#{proposal.id}"

      
    end
  end
end
