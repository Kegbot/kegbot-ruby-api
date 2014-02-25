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
