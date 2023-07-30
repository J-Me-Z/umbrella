
pp "Where are you located?"

user_location= gets.chomp.gsub(" ","%20")
#user_location = "Cleveland"

 pp user_location

 maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address="+ user_location + "&key=" + ENV.fetch("GMAPS_KEY")

 #pp maps_url

require "http"

resp = HTTP.get(maps_url)

# pp resp
raw_response = resp.to_s
# pp raw_response

require "json"
parsed_response =  JSON.parse(raw_response)
# p parsed_response.keys
results = parsed_response.fetch("results")

#pp results.at(0)
first_result = results.at(0)
 geo= first_result.fetch("geometry")

pp loc = geo.fetch("location")


# geometry_hash = first_result_hash.fetch("geometry")

# location_hash = geometry_hash.fetch("location")

pp latitude= loc.fetch("lat")

pp longitude  = loc.fetch("lng")

# puts "Your coordinates are #{latitude}, #{longitude}."

# # I've already created a string variable above: pirate_weather_api_key
# # It contains sensitive credentials that hackers would love to steal so it is hidden for security reasons.

require "http"

# # Assemble the full URL string by adding the first part, the API token, and the last part together

 pirate_weather_api_key = ENV.fetch("PIRATE_WEATHER_KEY")
 # pirate_weather_url = "https://api.pirateweather.net/forecast/" + pirate_weather_api_key + ,-87.6355"

 pp pirate_weather_url = "https://api.pirateweather.net/forecast/#{pirate_weather_api_key}/#{latitude},#{longitude}"

# # Place a GET request to the URL
raw_response = HTTP.get(pirate_weather_url)

require "json"

parsed_response = JSON.parse(raw_response)

pp currently_hash = parsed_response.fetch("currently")

current_temp = currently_hash.fetch("temperature")
precip_prob = currently_hash.fetch("precipProbability")

pp precip_prob

puts "The current temperature is " + current_temp.to_s + "."

#playing with minute data 
# Some locations around the world do not come with minutely data.
  
minutely_hash = parsed_response.fetch("minutely", false)
  
  if minutely_hash
    next_hour_summary = minutely_hash.fetch("summary")
  
    puts "Next hour: #{next_hour_summary}"
  end
  
 hourly_hash = parsed_response.fetch("hourly")
  
hourly_hash

hourly_data_array = hourly_hash.fetch("data")
  
pp next_twelve_hours = hourly_data_array[1..12]
  
 precip_prob_threshold = 0.10
  
any_precipitation = false
  
  next_twelve_hours.each do |hour_hash|
  
   precip_prob = hour_hash.fetch("precipProbability")
  
   if precip_prob > precip_prob_threshold
     any_precipitation = true
  
     precip_time = Time.at(hour_hash.fetch("time"))
    seconds_from_now = precip_time - Time.now
     hours_from_now = seconds_from_now / 60 / 60
     puts "In #{hours_from_now.round} hours, there is a #{(precip_prob * 100).round}% chance of precipitation."
    end
 end
  
   if any_precipitation == true
    puts "You might want to take an umbrella!"
   else
    puts "You probably won't need an umbrella."
  end
  
