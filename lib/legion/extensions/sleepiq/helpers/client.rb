require 'sleepiq'

module Legion::Extensions::Sleepiq
  module Helpers
    module Client
      extend Legion::Cache::Helper
      extend Legion::Logging::Helper

      def client(**_opts)
        @awsalb = cache_get('awsalb')
        @bedid  = cache_get('bedid')
        @key    = cache_get('key')
        @sessid = cache_get('sessid')

        login if @awsalb.nil? || @key.nil? || @sessid.nil?
        ::SleepIQ::Client.new(awsalb: @awsalb, key: @key, sessid: @sessid, bedid: @bedid)
      rescue StandardError => e
        log.fatal e.message
        log.fatal e.backtrace
        raise(e)
      end

      def login
        result = ::SleepIQ::Client.new(username: username, password: password)
        cache_set('sessid', result.sessid, ttl: 600)
        @sessid = result.sessid
        cache_set('awsalb', result.awsalb, ttl: 600)
        @awsalb = result.awsalb
        cache_set('key', result.key, ttl: 600)
        @key = result.key
        cache_set('bedid', result.bedid, ttl: 600)
        @bedid = result.bedid
      end

      def username(**)
        @username = find_setting('username', **)
      end

      def password(**)
        @password = find_setting('password', **)
      end
    end
  end
end
