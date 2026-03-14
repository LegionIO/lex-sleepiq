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

## Requirements

- Ruby >= 3.4
- [LegionIO](https://github.com/LegionIO/LegionIO) framework
- Sleep Number SleepIQ account (username + password)
- `legion-cache` for session token storage

## License

MIT
