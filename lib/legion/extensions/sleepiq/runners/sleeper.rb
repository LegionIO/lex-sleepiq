module Legion::Extensions::Sleepiq
  module Runners
    module Sleeper
      include Legion::Extensions::Helpers::Lex
      extend Legion::Extensions::Sleepiq::Helpers::Client

      def sleeper(**)
        client.sleeper
      end

      def sleep_data(date:, interval: 'D1', **)
        client.sleep_data(date, interval)
      end

      def sleep_slice_data(date:, interval: 'D1', **)
        client.sleep_slice_data(date, interval)
      end
    end
  end
end
