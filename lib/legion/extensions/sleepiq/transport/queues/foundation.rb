module Legion
  module Extensions
    module Sleepiq
      module Transport
        module Queues
          class Foundation < Legion::Transport::Queue
            def queue_name
              'sleepiq.foundation'
            end
          end
        end
      end
    end
  end
end
