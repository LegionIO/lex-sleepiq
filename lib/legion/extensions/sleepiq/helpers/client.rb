require 'sleepiq'

module Legion::Extensions::Sleepiq
  module Helpers
    module Client
      def client(**opts)
        @awsalb = Legion::Cache.get('sleepiq_awsalb')
        @bedid = Legion::Cache.get('sleepiq_bedid')
        @key = Legion::Cache.get('sleepiq_key')
        @sessid = Legion::Cache.get('sleepiq_sessid')

        login if @awsalb.nil? || @key.nil? || @sessid.nil?
        return ::SleepIQ::Client.new(awsalb: @awsalb, key: @key, sessid: @sessid, bedid: @bedid)
      rescue => e
        Legion::Logging.fatal e.message
        Legion::Logging.fatal e.backtrace
        raise(e)
      end

      def login
        result = ::SleepIQ::Client.new(username: username, password: password)
        Legion::Cache.set('sleepiq_sessid', result.sessid, 600)
        @sessid = result.sessid
        Legion::Cache.set('sleepiq_awsalb', result.awsalb, 600)
        @awsalb = result.awsalb
        Legion::Cache.set('sleepiq_key', result.key, 600)
        @key = result.key
        Legion::Cache.set('sleepiq_bedid', result.bedid, 600)
        @bedid = result.bedid
      end

      def username(username: nil)
        @username unless @username.nil?
        @username = username unless username.nil?
        @username = ENV['sleepiq_username'] unless ENV['sleepiq_username'].nil?
        cache = Legion::Cache.get('sleepiq_username') if Legion::Settings[:cache][:connected]
        @username = cache unless cache.nil? if Legion::Settings[:cache][:connected]
        @username = settings['username']
      end

      def password(password: nil)
        @password unless @password.nil?
        @password = password unless password.nil?
        @password = ENV['sleepiq_password'] unless ENV['sleepiq_password'].nil?
        cache = Legion::Cache.get('sleepiq_password') if Legion::Settings[:cache][:connected]
        @password = cache unless cache.nil? if Legion::Settings[:cache][:connected]
        @password = settings['password']
      end
    end
  end
end