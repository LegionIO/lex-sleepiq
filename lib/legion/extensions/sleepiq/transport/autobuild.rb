require 'legion/extensions/transport/autobuild'

module Legion
  module Extensions
    module Sleepiq
      module Transport
        module AutoBuild
          extend Legion::Extensions::Transport::AutoBuild
          def self.e_to_q
            [{
              from:        'sleepiq',
              to:          'foundation',
              routing_key: 'foundation'
            }, {
              from:        'sleepiq',
              to:          'bed',
              routing_key: 'bed'
            }, {
              from:        'sleepiq',
              to:          'pump',
              routing_key: 'pump'
            }, {
              from:        'sleepiq',
              to:          'family',
              routing_key: 'family'
            }, {
              from:        'sleepiq',
              to:          'sleeper',
              routing_key: 'sleeper'
            }]
          end
        end
      end
    end
  end
end
