# KegbotApi

[Kegbot](https://kegbot.org/) Server [REST API](https://kegbot.org/docs/api/) client implemented in Ruby.

## Installation

Add this line to your application's Gemfile:

    gem 'kegbot_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kegbot_api

## Usage

Using the `KegbotApi` is pretty straight-forward.

### Example 1

``` ruby
require 'kegbot_api'

#
# Example use of the KegbotApi
#

client = KegbotApi::Client.new "http://demo.kegbot.org/api"

puts "KegbotApi Demo"
puts "http://demo.kegbot.org/api"
puts "--------------"

taps = client.Tap.all

puts "Taps: #{taps.length}"
puts "--------------"

taps.each_with_index do |tap, index|
  puts "Tap #{index + 1}"
  puts tap.name
  puts "Online? #{tap.online?}"

  if tap.online?
    puts "On Tap: #{tap.keg.name}"

    puts "Remaining: #{tap.keg.volume_ml_remaining}ml of #{tap.keg.volume_ml}ml"
    puts '%.0f%' % tap.keg.percent_full
  end

  puts "--------------"
end

# Or you can find resources by ID...for example: Keg 1

puts "GET /kegs/1"
tap = client.Keg.find(1)

[:id, :name, :size_name, :volume_ml_remaining, :percent_full, :online?].each do |name|
  puts "#{name} = #{tap.send(name)}"
end
```

produces output:

``` text
KegbotApi Demo
http://demo.kegbot.org/api
--------------
Taps: 2
--------------
Tap 1
Main Tap
Online? true
On Tap: Drake's 1500
Remaining: 21796.9ml of 58673.9ml
37%
--------------
Tap 2
Second Tap
Online? true
On Tap: Anchor Steam
Remaining: 21005.9ml of 58673.9ml
36%
--------------
GET /kegs/1
id = 1
name = Drake's Blonde
size_name = half-barrel
volume_ml_remaining = 80.90000000000146
percent_full = 0.13788072720579586
online? = false
```

Source is at [`spec/example_1.rb`](spec/example_1.rb)

### Example 2

``` ruby
require 'kegbot_api'

#
# REST endpoints and their corresponding KegbotApi classes/methods
#

client = KegbotApi::Client.new "http://demo.kegbot.org/api"

# /drinks
client.Drink.all

# /drinks/ID
client.Drink.find(1)

# /taps
client.Tap.all

# /kegs
client.Keg.all

# /kegs/ID
client.Keg.find(1)

# /sessions
client.Session.all

# /sessions/ID
client.Session.find(1)
```

Source is at [`spec/example_2.rb`](spec/example_2.rb)


For more examples, see the rspec test cases in the [`spec` directory](spec)

## Limitations

The [Kegbot Server REST API specification](https://kegbot.org/docs/api/) is in flux (as mentioned on the specification page).  As such, things might break.  Open an issue, or even better, a pull request!

The Kegbot Server REST API specification is a bit out of date to what the server actually returns...as such, when in doubt, hit the REST URL directly and see what you see:  eg: http://demo.kegbot.org/api/taps

Currently, the API is for unauthenticated and read-only content: `taps`, `kegs`, and `drinks` endpoints and their sub-objects `beverage`, `image`.  The following are not fully implemented yet:

* GET `/taps/ID`
* GET `/kegs/ID/drinks`
* GET `/kegs/ID/sessions`
* GET `/users`
* GET `/users/ID`
* GET `/users/ID/drinks`
* GET `/users/ID/auth-tokens`
* GET `/thermo-sensors`
* All POST Endpoints

That being said, the API is complete for querying most information from a Kegbot server.

## Version History

See [CHANGELOG.md](CHANGELOG.md) for a complete version history.

## Branch Convention

* `master`
  * Latest stable version
* `develop`
  * Bleeding edge development
* `wip*`
  * Work in progress (WIP).  Should not be used unless you absolutely know what you're doing.

## Contributing

1. Fork it ( https://github.com/kegbot/kegbot_ruby_api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
