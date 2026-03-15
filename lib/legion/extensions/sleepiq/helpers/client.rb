require 'sleepiq'

module Legion::Extensions::Sleepiq
  module Helpers
    module Client
      def client(**_opts)
        @awsalb = Legion::Cache.get('sleepiq_awsalb')
        @bedid = Legion::Cache.get('sleepiq_bedid')
        @key = Legion::Cache.get('sleepiq_key')
        @sessid = Legion::Cache.get('sleepiq_sessid')

        login if @awsalb.nil? || @key.nil? || @sessid.nil?
        ::SleepIQ::Client.new(awsalb: @awsalb, key: @key, sessid: @sessid, bedid: @bedid)
      rescue StandardError => e
        Legion::Logging.fatal e.message
        Legion::Logging.fatal e.backtrace
        raise(e)
      end

      def login
        result = ::SleepIQ::Client.new(username: username, password: password)
        Legion::Cache.set('sleepiq_sessid', result.sessid, ttl: 600)
        @sessid = result.sessid
        Legion::Cache.set('sleepiq_awsalb', result.awsalb, ttl: 600)
        @awsalb = result.awsalb
        Legion::Cache.set('sleepiq_key', result.key, ttl: 600)
        @key = result.key
        Legion::Cache.set('sleepiq_bedid', result.bedid, ttl: 600)
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
