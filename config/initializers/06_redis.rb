$redis = Redis::Namespace.new("weather_app", :redis => Redis.new)

$redis.set("santiago", { lat: '-33.45694', lon: '-70.64827'}.to_json)
$redis.set("zurich", { lat: '47.36667', lon: '8.55'}.to_json)
$redis.set("auckland", { lat: '-36.86667', lon: '174.76667'}.to_json)
$redis.set("sydney", { lat: '-33.86785', lon: '151.20732'}.to_json)
$redis.set("londres", { lat: '51.50853', lon: '-0.12574'}.to_json)
$redis.set("georgia", { lat: '33.749', lon: '-84.38798'}.to_json)