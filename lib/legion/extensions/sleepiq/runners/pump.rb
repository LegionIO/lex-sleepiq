module Legion::Extensions::Sleepiq
  module Runners
    module Pump
      include Legion::Extensions::Helpers::Lex
      extend Legion::Extensions::Sleepiq::Helpers::Client

      def pump_status(bedid: nil, **opts)
        return normalize(client.pump_status)
      end

      def force_idle(bedid: nil, **opts)
        return normalize(client.force_idle)
      end
    end
  end
end
