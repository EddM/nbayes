module NBayes
  class Classifier
    attr_reader :training_set

    def initialize(training_set)
      @training_set = training_set
    end

    def classes
      @training_set.classes
    end

    # classify(foo: 1, bar: 2)
    def classify(features)
      evidence = calculate_evidence(features)
      class_scores = {}

      # for each class
      training_set.classes.each do |klass|
        class_scores[klass] = score_for_class(klass, features, evidence)
      end

      class_scores.max_by { |_klass, score| score }.first
    end

    private

    def product(terms)
      terms
        .reject(&:zero?)
        .inject(:*)
    end

    # find P(X) general probability
    def calculate_evidence(features)
      feature_scores = features.map do |feature_label, feature_value|
        count = training_set.data.count do |datum|
          datum.features[feature_label] == feature_value
        end

        count / training_set.total_samples.to_f
      end

      product(feature_scores)
    end

    def score_for_class(klass, features, evidence)
      data = training_set.data_for_class(klass)
      samples = data.size.to_f
      total_samples = training_set.total_samples.to_f

      scores = features.map do |feature_label, feature_value|
        score_for_feature_given_class(data, feature_label, feature_value)
      end

      # find P(class) general probability
      scores << samples / total_samples

      product(scores) / evidence
    end

    # calculate P(x | class)
    def score_for_feature_given_class(data, feature_label, feature_value)
      samples_with_feature = data.count do |datum|
        datum.features[feature_label] == feature_value
      end

      samples_with_feature / data.size.to_f
    end
  end
end
