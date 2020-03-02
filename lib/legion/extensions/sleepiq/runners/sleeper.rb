module Legion::Extensions::Sleepiq
  module Runners
    module Sleeper
      include Legion::Extensions::Helpers::Lex
      extend Legion::Extensions::Sleepiq::Helpers::Client

      def self.status(payload); end

      def self.preset(payload); end

      def self.system(payload); end

      def self.motion(payload); end
    end
  end
end
