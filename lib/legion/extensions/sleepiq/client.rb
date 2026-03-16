# frozen_string_literal: true

require 'sleepiq'

# Stub framework helpers when running standalone (outside full Legion framework)
unless defined?(Legion::Extensions::Helpers::Lex)
  module Legion
    module Extensions
      module Helpers
        module Lex; end
      end
    end
  end
end

# Stub the Helpers::Client module so runner `extend` calls are no-ops standalone
unless defined?(Legion::Extensions::Sleepiq::Helpers::Client)
  module Legion
    module Extensions
      module Sleepiq
        module Helpers
          module Client; end
        end
      end
    end
  end
end

require_relative 'runners/bed'
require_relative 'runners/family'
require_relative 'runners/foundation'
require_relative 'runners/pump'
require_relative 'runners/sleeper'

module Legion
  module Extensions
    module Sleepiq
      class Client
        include Runners::Bed
        include Runners::Family
        include Runners::Foundation
        include Runners::Pump
        include Runners::Sleeper

        attr_reader :opts, :username, :password

        def initialize(username:, password:, **opts)
          @username = username
          @password = password
          @opts = opts
          @awsalb = nil
          @key = nil
          @sessid = nil
          @bedid = nil
        end

        def client(**)
          login if @awsalb.nil? || @key.nil? || @sessid.nil?
          ::SleepIQ::Client.new(awsalb: @awsalb, key: @key, sessid: @sessid, bedid: @bedid)
        end

        def login
          result = ::SleepIQ::Client.new(username: @username, password: @password)
          @sessid = result.sessid
          @awsalb = result.awsalb
          @key = result.key
          @bedid = result.bedid
          result
        end

        private

        def normalize(data)
          case data
          when Hash then data.transform_keys(&:to_sym).transform_values { |v| normalize(v) }
          when Array then data.map { |v| normalize(v) }
          else data
          end
        end
      end
    end
  end
end
