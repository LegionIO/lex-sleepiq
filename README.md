# lex-sleepiq

Sleep Number SleepIQ integration for [LegionIO](https://github.com/LegionIO/LegionIO). Control and query Sleep Number beds including sleep number adjustment, foundation control, pump status, and sleep data.

## Installation

```bash
gem install lex-sleepiq
```

Or add to your Gemfile:

```ruby
gem 'lex-sleepiq'
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

Credentials are used for initial login. Session tokens are cached automatically (10-minute TTL) via legion-cache and refreshed as needed.

## Runners

| Runner | Methods |
|--------|---------|
| Bed | `sleep_number`, `set_sleep_number`, `get_sleep_number_favorite`, `set_sleep_number_favorite`, `status`, `get_pause_mode`, `set_pause_mode`, `get` |
| Family | `family_status` - bed occupancy and side data summary |
| Foundation | `get_light`, `set_light`, `preset`, `stop_motion`, `status`, `system` |
| Pump | `pump_status`, `force_idle` |
| Sleeper | `sleeper`, `sleep_data`, `sleep_slice_data` |

## Polling Actor

`Legion::Extensions::Sleepiq::Actors::Poll` automatically polls `Family#family_status` on an interval. This provides ongoing bed occupancy and pressure data without manual task triggers.

## Standalone Client

Use `lex-sleepiq` as a standalone library without the full LegionIO framework:

```ruby
require 'legion/extensions/sleepiq/client'

client = Legion::Extensions::Sleepiq::Client.new(username: 'user@example.com', password: 'secret')

# Session tokens are fetched automatically on first call
client.status
client.sleep_number(side: 'R')
client.family_status
client.pump_status
client.sleeper
client.sleep_data(date: '2026-03-15', interval: 'D1')
```

Session tokens (`awsalb`, `key`, `sessid`, `bedid`) are stored as instance variables and reused across calls. Call `client.login` explicitly to force re-authentication.

## Requirements

- Ruby >= 3.4
- Sleep Number SleepIQ account (username + password)
- [LegionIO](https://github.com/LegionIO/LegionIO) framework (optional — standalone Client works without it)

## License

MIT
