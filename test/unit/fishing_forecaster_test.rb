require File.dirname(__FILE__) + '/../test_helper'

class FishingForecasterTest < Test::Unit::TestCase
  
  def setup
  end
  
  def teardown
    FishingForecaster.weather_forecaster = nil
    assert_not_nil FishingForecaster.weather_forecaster
  end
  
  def test_fishing_forecaster_default
    assert_not_nil FishingForecaster.weather_forecaster
  end
  
  def test_weather_forecaster_getter_setter
    weather_forecaster = dummy_object
    assert_not_equal weather_forecaster, FishingForecaster.weather_forecaster
    FishingForecaster.weather_forecaster = weather_forecaster
    assert_equal weather_forecaster, FishingForecaster.weather_forecaster
  end
  
private

end
