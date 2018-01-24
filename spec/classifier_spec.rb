require "spec_helper"
require "Classifier"

describe NBayes::Classifier do
  describe "#classes" do
    it "is delegated to its training set object" do
      training_set_double = double(classes: [:foo, :bar])
      subject = described_class.new(training_set_double)

      expect(subject.classes).to eq([:foo, :bar])
    end
  end

  describe "#classify" do
    subject { described_class.new(training_set) }

    let(:training_data) do
      [
        [:no, { temp: :hot, humidity: :high }],
        [:no, { temp: :hot, humidity: :high }],
        [:yes, { temp: :hot, humidity: :high }],
        [:yes, { temp: :mild, humidity: :high }],
        [:yes, { temp: :cool, humidity: :normal }],
        [:no, { temp: :cool, humidity: :normal }],
        [:yes, { temp: :cool, humidity: :normal }],
        [:no, { temp: :mild, humidity: :high }],
        [:yes, { temp: :cool, humidity: :normal }],
        [:yes, { temp: :mild, humidity: :normal }],
        [:yes, { temp: :mild, humidity: :normal }],
        [:yes, { temp: :mild, humidity: :high }],
        [:yes, { temp: :hot, humidity: :normal }],
        [:no, { temp: :mild, humidity: :high }]
      ]
    end

    let(:training_set) do
      NBayes::TrainingSet.new([:no, :yes])
    end

    before :each do
      training_data.each do |sample|
        training_set.train sample.first, sample.last
      end
    end

    it "correctly classifies a sample" do
      classification = subject.classify(temp: :cool, humidity: :high)

      expect(classification).to eq(:yes)
    end
  end
end
