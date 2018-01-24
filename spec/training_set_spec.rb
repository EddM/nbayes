require "spec_helper"
require "training_set"
require "tuple"

describe NBayes::TrainingSet do
  subject { described_class.new }

  describe "#train" do
    it "adds the data" do
      expect do
        subject.train(:foo, a: 1, b: 2)
      end.to change { subject.data.size }.from(0).to(1)
    end

    it "adds the data as a tuple" do
      subject.train(:foo, a: 1, b: 2)

      expect(subject.data.first).to be_a(NBayes::Tuple)
    end

    it "adds the given class to the class list" do
      subject.train(:foo, a: 1, b: 2)

      expect(subject.classes).to match_array([:foo])
    end

    context "when the class already exists" do
      subject { described_class.new([:foo]) }

      it "doesn't add the given class to the class list as a duplicate" do
        expect do
          subject.train(:foo, a: 1, b: 2)
        end.to_not change { subject.classes }
      end
    end
  end
end
