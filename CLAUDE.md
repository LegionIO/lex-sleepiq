# lex-sleepiq: Sleep Number SleepIQ Integration for LegionIO

**Repository Level 3 Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-other/CLAUDE.md`
- **Grandparent**: `/Users/miverso2/rubymine/legion/CLAUDE.md`

## Purpose

Legion Extension that connects LegionIO to the Sleep Number SleepIQ API. Provides runners for controlling and querying Sleep Number beds, including sleep number adjustment, foundation control, pump status, sleeper data, and family status. A polling actor automatically fetches family status on an interval.

**GitHub**: https://github.com/LegionIO/lex-sleepiq
**License**: MIT

## Architecture

```
Legion::Extensions::Sleepiq
├── Runners/
│   ├── Bed          # Sleep number get/set, favorites, status, pause mode
│   ├── Family       # Family status summary (bed occupancy, side data)
│   ├── Foundation   # Foundation light/preset/stop-motion/status/system
│   ├── Pump         # Pump status and force-idle
│   └── Sleeper      # Sleeper info, sleep data, sleep slice data
├── Helpers/
│   └── Client       # SleepIQ::Client wrapper; session cached in legion-cache (TTL 600s)
├── Client           # Standalone client class; includes all runners; self-managed session tokens
└── Actors/
    └── Poll         # Polling actor: calls Family#family_status on interval
```

## Key Files

| Path | Purpose |
|------|---------|
| `lib/legion/extensions/sleepiq.rb` | Entry point, extension registration |
| `lib/legion/extensions/sleepiq/runners/bed.rb` | sleep_number, set_sleep_number, status, pause_mode |
| `lib/legion/extensions/sleepiq/runners/family.rb` | family_status (normalized, lastLink stripped) |
| `lib/legion/extensions/sleepiq/runners/foundation.rb` | Light, preset, stop_motion, status, system |
| `lib/legion/extensions/sleepiq/runners/pump.rb` | pump_status, force_idle |
| `lib/legion/extensions/sleepiq/runners/sleeper.rb` | sleeper, sleep_data, sleep_slice_data |
| `lib/legion/extensions/sleepiq/helpers/client.rb` | Session management and SleepIQ::Client factory |
| `lib/legion/extensions/sleepiq/client.rb` | Standalone Client class; includes all runners; owns session state |
| `lib/legion/extensions/sleepiq/actors/poll.rb` | Poll actor targeting Family#family_status |
| `lib/legion/extensions/sleepiq/version.rb` | Version constant (0.2.3) |

## Session Management

### Framework path (Helpers::Client)

When running inside the Legion framework, `Helpers::Client` authenticates via username/password and caches session tokens in `legion-cache`:

| Cache Key | Contents | TTL |
|-----------|----------|-----|
| `sleepiq_awsalb` | AWS ALB cookie | 600s |
| `sleepiq_key` | Session key | 600s |
| `sleepiq_sessid` | Session ID | 600s |
| `sleepiq_bedid` | Bed ID | 600s |

If any session value is missing from cache, `login` is called automatically before the next API call.

### Standalone path (Client class)

`Legion::Extensions::Sleepiq::Client` manages session tokens as instance variables (`@awsalb`, `@key`, `@sessid`, `@bedid`) instead of using Legion::Cache. `login` is called automatically inside `client` whenever any token is `nil`. There is no TTL; tokens persist for the lifetime of the Client instance.

```ruby
c = Legion::Extensions::Sleepiq::Client.new(username: 'user@example.com', password: 's3cr3t')
c.family_status   # calls login on first use, then returns family status
c.sleep_number    # reuses existing session
```

## Configuration

```json
{
  "extensions": {
    "sleepiq": {
      "enabled": true,
      "username": "your_sleepiq_username",
      "password": "your_sleepiq_password"
    }
  }
}
```

## Gemspec Notes

- The gemspec still references the old Bitbucket URL (`bitbucket.org/legion-io/lex-sleepiq`). Update to `github.com/LegionIO/lex-sleepiq`.
- Required Ruby version in gemspec is `>= 2.5.0` (stale). Framework requires >= 3.4.
- `rubygems_mfa_required` metadata is not yet set.

## Dependencies

| Gem | Purpose |
|-----|---------|
| `sleepiq` (>= 0.3.0) | Sleep Number SleepIQ Ruby client |

## Development

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

---

**Maintained By**: Matthew Iverson (@Esity)
