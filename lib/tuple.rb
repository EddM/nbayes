module NBayes
  class Tuple
    attr_reader :klass, :features

    def initialize(klass, features)
      @klass = klass
      @features = features
    end
  end
end
