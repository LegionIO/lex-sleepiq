module Legion::Extensions::Sleepiq
  module Runners
    module Family
      include Legion::Extensions::Helpers::Lex
      extend Legion::Extensions::Sleepiq::Helpers::Client

      def family_status(**_opts)
        results = normalize(client.family_status)
        results[:beds][0][:leftSide].delete(:lastLink)
        results[:beds][0][:rightSide].delete(:lastLink)
        results
      end
    end
  end
end
