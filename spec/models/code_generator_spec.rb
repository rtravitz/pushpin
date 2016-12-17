require "rails_helper"

describe "CodeGenerator" do
  it "generates a 6 digit code as a string" do
    code = CodeGenerator.generate

    expect(code.length).to eq(6)
    expect(code).to be_a(String)
  end
end
