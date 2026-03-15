# frozen_string_literal: true

require_relative 'lib/legion/extensions/sleepiq/version'

Gem::Specification.new do |spec|
  spec.name          = 'lex-sleepiq'
  spec.version       = Legion::Extensions::Sleepiq::VERSION
  spec.authors       = ['Esity']
  spec.email         = ['matthewdiverson@gmail.com']
  spec.summary       = 'LEX::SleepIQ'
  spec.description   = 'Used to connect Legion to Sleep Number SleepIQ API'
  spec.homepage      = 'https://github.com/LegionIO/lex-sleepiq'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.4'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/LegionIO/lex-sleepiq'
  spec.metadata['documentation_uri'] = 'https://github.com/LegionIO/lex-sleepiq'
  spec.metadata['changelog_uri'] = 'https://github.com/LegionIO/lex-sleepiq'
  spec.metadata['bug_tracker_uri'] = 'https://github.com/LegionIO/lex-sleepiq/issues'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.require_paths = ['lib']

  spec.add_dependency 'sleepiq', '>= 0.3.0'
end
