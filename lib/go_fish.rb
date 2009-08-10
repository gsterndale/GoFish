require File.dirname(__FILE__) + '/fishing_forecaster'

class GoFish
  
  @@positive_response           = "Go fish"
  @@negative_response           = "Hack"
  @@default_fishing_forecaster  = FishingForecaster
  @@fishing_forecaster          = @@default_fishing_forecaster
  
  def self.positive_response
    @@positive_response
  end
  
  def self.negative_response
    @@negative_response
  end
  
  def self.fishing_forecaster
    @@fishing_forecaster ||= @@default_fishing_forecaster
  end
  
  def self.fishing_forecaster=(forecaster)
    @@fishing_forecaster = forecaster
  end
  
  def self.fish_today?
    fishing_forecaster.likelihood_of_catch >= 0.5 ? positive_response : negative_response
  end
  
end
