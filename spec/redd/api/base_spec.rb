RSpec.describe Redd::API::Access do
  describe ".property" do
    it "defines a reader method"
    it "defines a predicate method"
  end

  describe ".from_response" do
    it "allows accessing the data"
    it "allows accessing the kind"
  end

  describe "#response" do
    it "returns the hash used to create it"
    it "returns a flattened hash if ::from_response was used"
  end
end
