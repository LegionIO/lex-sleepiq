module Legion::Extensions::Sleepiq
  module Runners
    module Foundation
      include Legion::Extensions::Helpers::Lex
      extend Legion::Extensions::Sleepiq::Helpers::Client

      def get_light(light: 1, **)
        client.light(light)
      end

      def set_light(light:, setting: 0, **)
        client.set_light(light, setting)
      end

      def preset(preset:, side: 'R', slow_speed: 0, **)
        client.preset(preset, side, slow_speed)
      end

      def stop_motion(side: 'R', **)
        client.stop_motion(side)
      end

      def status(**)
        client.foundation_status
      end

      def system(**)
        client.system
      end
    end
  end
end
