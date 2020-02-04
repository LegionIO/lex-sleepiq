module Legion
  module Extensions
    module Sleepiq
      module Transport
        module Queues
          class Family < Legion::Transport::Queue
            def queue_name
              'sleepiq.family'
            end
          end
        end
      end
    end
  end
end
