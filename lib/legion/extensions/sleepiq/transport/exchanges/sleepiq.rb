module Legion
  module Extensions
    module Sleepiq
      module Transport
        module Exchanges
          class Sleepiq < Legion::Transport::Exchange
            def exchange_name
              'sleepiq'
            end
          end
        end
      end
    end
  end
end
