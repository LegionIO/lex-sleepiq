module Legion
  module Extensions
    module Sleepiq
      module Transport
        module Queues
          class Sleeper < Legion::Transport::Queue
            def queue_name
              'sleepiq.sleeper'
            end
          end
        end
      end
    end
  end
end
