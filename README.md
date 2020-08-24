# Legion::Extensions::Sleepiq

A Legion Extension designed to connect with SleepIQ by Sleep Number
Uses the [sleepiq](https://rubygems.org/gems/sleepiq) gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lex-sleepiq'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install lex-sleepiq

## Adding to Legion
You can manually install with a `gem install lex-http` command or by adding it into your settings with something like this
```json
{
  "extensions": {
    "sleepiq": {
      "enabled": true, 
      "workers": 1,
      "username": "*sleep_iq_username*",
      "password": "*sleep_iq_password*"
    }
  }
}
```

##### Runners
|runner|description|completed?|
|---|---|---|
|bed|Bed functions|no|
|family|used to query the family endpoint to get a summary|yes|
|foundation|used to control and query foundations|no|
|pump|used to control and query the pump|yes|
|sleeper|Used to query the sleeper endpoint|no|

## Usage
Control and query your bed. `Legion::Extensions::Sleepiq::Actors::Poll` will automatically every 10 seconds. This 
will include things like person in bed status and the pump pressure

