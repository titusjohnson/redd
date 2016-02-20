RSpec.describe Redd::API::Access do
  subject(:access) do
    Redd::API::Access.new(
      double(Redd::Client::Base),
      access_token:  "ACCESS_TOKEN",
      token_type:    "bearer",
      expires_in:    1800,
      scope:         "identity,edit,read",
      refresh_token: "REFRESH_TOKEN"
    )
  end

  describe "#scope" do
    subject { access.scope }
    it { is_expected.to be_an(Array) }
    it { is_expected.to contain_exactly("identity", "edit", "read") }
  end

  describe "#issued_at" do
    subject { access.issued_at }
    context "when issued_at is provided" do
      it "returns a correct issue time"
    end
    context "when issued_at isn't provided" do
      it "uses the current time"
    end
  end

  describe "#temporary?" do
    context "refresh token is provided" do
      it "returns false"
    end
    context "refresh token isn't provided" do
      it "returns true"
    end
  end

  describe "#permanent?" do
    context "refresh token is provided" do
      it "returns true"
    end
    context "refresh token isn't provided" do
      it "returns false"
    end
  end

  describe "#expires_at" do
    it "returns a slightly pessimistic expiry time"
  end

  describe "#expired?" do
    context "when expired" do
      it "returns true"
    end
    context "when there is time left" do
      it "returns false"
    end
  end
end
