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
