require File.dirname(__FILE__) + '/weather_forecaster'

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
    calculate_likelihood_of_catch(likelihood_of_rain)
  end
  
protected
  
  def self.calculate_likelihood_of_catch(rain)
    1-Math.sqrt(rain)
  end
  
end