class FishingForecaster
  
  @@weather_forecaster  = ""
  
  def self.weather_forecaster
    @@weather_forecaster
  end
  
  def self.weather_forecaster=(forecaster)
    @@weather_forecaster = forecaster
  end
  
end