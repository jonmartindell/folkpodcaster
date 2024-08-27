require "wkar"

describe Wkar do
  describe ".record" do
    subject { described_class.record }
    it "returns a file" do
      expect(subject).to be_a File
      expect(subject.path).to eq("output.aac")
    end
  end
end
