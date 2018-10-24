class WeatherChannel < ApplicationCable::Channel
  def subscribed
    stream_from "weather"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
