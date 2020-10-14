module Legion::Extensions::Sleepiq
  module Runners
    module Bed
      include Legion::Extensions::Helpers::Lex
      extend Legion::Extensions::Sleepiq::Helpers::Client
      def sleep_number(side: 'R', **)
        client.sleep_number(side)
      end

      def set_sleep_number(side: 'R', number: 50, **)
        client.update_sleep_number(number, side)
      end

      def get_sleep_number_favorite(side: 'R', **)
        client.sleep_number_fav(side)
      end

      def set_sleep_number_favorite(number:, side: 'R', **)
        client.update_sleep_number_fav
      end

      def status(**)
        client.status
      end

      def get_pause_mode(**)
        client.pause_mode
      end

      def set_pause_mode(mode: 'off', **)
        client.update_pause_mode(mode)
      end

      def get(**)
        client.bed
      end
    end
  end
end
