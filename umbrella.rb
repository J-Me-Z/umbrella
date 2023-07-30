
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

# require "http"

# # Assemble the full URL string by adding the first part, the API token, and the last part together

# pirate_weather_api_key = ENV.fetch("PIRATE_WEATHER_KEY")
# pirate_weather_url = "https://api.pirateweather.net/forecast/" + pirate_weather_api_key + "/41.8887,-87.6355"

# # Place a GET request to the URL
# raw_response = HTTP.get(pirate_weather_url)

# require "json"

# parsed_response = JSON.parse(raw_response)

# currently_hash = parsed_response.fetch("currently")

# current_temp = currently_hash.fetch("temperature")

# puts "The current temperature is " + current_temp.to_s + "."
