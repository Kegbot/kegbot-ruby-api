require 'kegbot_api'

#
# Example use of the Kegbot API /stats endpoint.
#

client = KegbotApi::Client.new "http://demo.kegbot.org/api"

stats = client.Stat.find

puts "Summary Statistics"
puts client.base_url
puts "-----------------------"

puts "#{stats.total_pours} drinks"
puts "#{stats.sessions_count} sessions "
puts "#{stats.drinkers.length} drinkers"
puts "-----------------------"

puts "Top Drinkers"
stats.volume_by_drinker.each do |drinker, volume_ml|
  puts '%10s -> %5.0f pints' % [drinker, (volume_ml / 473.176)]
end

puts "-----------------------"
