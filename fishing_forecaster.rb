require 'weather_forecaster'

class FishingForecaster
  
  @@default_weather_forecaster  = WeatherForecaster
  @@weather_forecaster          = @@default_weather_forecaster
  
  def self.weather_forecaster
    @@weather_forecaster ||= @@default_weather_forecaster
  end
  
  def self.weather_forecaster=(forecaster)
    @@weather_forecaster = forecaster
  end
  
  def self.likelihood_of_catch
    likelihood_of_rain = weather_forecaster.likelihood_of_rain
    1-Math.sqrt(likelihood_of_rain)
  end
  
end