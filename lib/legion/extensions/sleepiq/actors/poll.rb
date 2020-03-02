module Legion::Extensions::Sleepiq
  module Actor
    class Poll < Legion::Extensions::Actors::Poll
      def runner_class
        Legion::Extensions::Sleepiq::Runners::Family
      end

      def runner_function
        'family_status'
      end

      def int_percentage_normalize
        0.02
      end
    end
  end
end