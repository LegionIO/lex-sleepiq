# Changelog

## [0.2.3] - 2026-03-15

### Added
- Standalone `Client` class (`Legion::Extensions::Sleepiq::Client`) that includes all runner modules and manages session tokens as instance variables, with no dependency on `Legion::Cache` or `Legion::Settings`
- 28 specs for the standalone Client covering initialization, login, auto-login, session caching, runner delegation, and data normalization
- `Metrics/BlockLength` spec exclusion in `.rubocop.yml`

## [0.2.2] - 2026-03-13

### Added
- Initial release
