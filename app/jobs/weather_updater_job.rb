class WeatherUpdaterJob < ApplicationJob
  queue_as :default

  class Error < StandardError
  end

  rescue_from Error, :with => :handle_error

  def handle_error(exception)
    $redis.hmset("api.error", Time.now, "Error trying to access Weather API")
  end

  def perform(*args)
    cities_data = [
      get_city_data("santiago"),
      get_city_data('zurich'),
      get_city_data('auckland'),
      get_city_data('sydney'),
      get_city_data('londres'),
      get_city_data('georgia')
    ]
    
    ActionCable.server.broadcast "weather", { message: render_cities(cities_data) }
  end

  private
  
  def get_city_data(city) 
    city = JSON.parse($redis.get(city))

    begin
      weather = get_weather(city["lat"], city["lon"])
      raise Error if !weather
    end while !weather


    unix_time = "#{weather.currently.time}"    
    date_time = "#{DateTime.strptime(unix_time,'%s').strftime("%H:%M:%S %p")}"    

    return {
      timezone: weather.timezone,
      temperature: weather.currently.apparentTemperature,
      time: date_time
    }
  end
  
  def get_weather(lat, lon)
    if rand(1..10) == 1 
      return false
    end

    ForecastIO.forecast(lat, lon, params: { units: 'si' })
  end

  def render_cities(cities_data)
    WeatherController.render(partial: 'cities', locals: { cities_data: cities_data }).squish
  end
end
