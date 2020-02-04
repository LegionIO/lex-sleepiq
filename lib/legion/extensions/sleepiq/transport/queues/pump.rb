module Legion
  module Extensions
    module Sleepiq
      module Transport
        module Queues
          class Pump < Legion::Transport::Queue
            def queue_name
              'sleepiq.pump'
            end
          end
        end
      end
    end
  end
end
