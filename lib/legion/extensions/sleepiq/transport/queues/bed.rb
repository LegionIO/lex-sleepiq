module Legion
  module Extensions
    module Sleepiq
      module Transport
        module Queues
          class Bed < Legion::Transport::Queue
            def queue_name
              'sleepiq.bed'
            end
          end
        end
      end
    end
  end
end
