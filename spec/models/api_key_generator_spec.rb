require "rails_helper"

describe "ApiKeyGenerator" do
  context "an api key is randomly generated" do
    it "generate_key" do
      key = ApiKeyGenerator.generate_key

      expect(key.length).to eq(32)
    end

    it "generates random combinations" do
      key1 = ApiKeyGenerator.generate_key
      key2 = ApiKeyGenerator.generate_key

      expect(key1).to_not eq(key2)
    end
  end
end
