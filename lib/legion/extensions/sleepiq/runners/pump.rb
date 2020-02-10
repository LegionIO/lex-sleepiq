module Legion::Extensions::Sleepiq
  module Runners
    module Pump
      def self.pump_status(_payload)
        sleep = SleepIQ.new
        sleep.pump_status
      end

      def self.force_idle(_payload)
        sleep = SleepIQ.new
        sleep.force_idle
      end
    end
  end
end
