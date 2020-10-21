require 'legion/extensions/sleepiq/version'

module Legion
  module Extensions
    module Sleepiq
      extend Legion::Extensions::Core if Legion::Extensions.const_defined? :Core
    end
  end
end
