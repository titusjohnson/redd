RSpec.describe Redd do
  it "has a version number" do
    expect(Redd::VERSION).not_to be nil
  end

  describe ".it" do
    context "when :userless is provided" do
      pending "returns a Userless client"
    end

    context "when :script is provided" do
      pending "returns a Script client"
    end
  end
end
