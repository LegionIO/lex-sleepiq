# Changelog

## [0.2.4] - 2026-03-22

### Changed
- Add legion-cache, legion-crypt, legion-data, legion-json, legion-logging, legion-settings, and legion-transport as runtime dependencies
- Replace direct `Legion::Cache.get/set` calls in `Helpers::Client` with `cache_get`/`cache_set` helpers (keys no longer carry redundant `sleepiq_` prefix — cache namespace provides it)
- Replace direct `Legion::Logging.fatal` calls in `Helpers::Client` with injected `log` helper
- Update spec_helper with real sub-gem helper stubs and Poll actor base class

## [0.2.3] - 2026-03-15

### Added
- Standalone `Client` class (`Legion::Extensions::Sleepiq::Client`) that includes all runner modules and manages session tokens as instance variables, with no dependency on `Legion::Cache` or `Legion::Settings`
- 28 specs for the standalone Client covering initialization, login, auto-login, session caching, runner delegation, and data normalization
- `Metrics/BlockLength` spec exclusion in `.rubocop.yml`

## [0.2.2] - 2026-03-13

### Added
- Initial release
