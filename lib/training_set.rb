require "set"
require "tuple"

module NBayes
  class TrainingSet
    attr_reader :classes, :data

    def initialize(classes = Set.new, initial_data = [])
      @classes = classes.to_set
      @data = initial_data
    end

    def total_samples
      @data.size
    end

    def train(klass, features)
      symbolized_class = klass.to_sym
      classes << symbolized_class unless classes.include?(symbolized_class)

      @data << NBayes::Tuple.new(symbolized_class, features)
    end

    def data_for_class(klass)
      @data.select { |datum| datum.klass == klass }
    end

    def data_with_feature(feature)
      @data.select { |datum| datum.features[feature_label] == feature_value }
    end

    private
  end
end
