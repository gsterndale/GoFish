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
  
  def test_likelihood_of_catch_0_likelihood_of_rain
    FishingForecaster.weather_forecaster = stub(:likelihood_of_rain => 0)
    assert_equal 1.0, FishingForecaster.likelihood_of_catch
  end
  
  def test_likelihood_of_catch_1_likelihood_of_rain
    FishingForecaster.weather_forecaster = stub(:likelihood_of_rain => 1)
    assert_equal 0.0, FishingForecaster.likelihood_of_catch
  end
  
  def test_likelihood_of_catch_inversely_related_to_likelihood_of_rain
    last_likelihood_of_catch = nil
    [0, 0.1, 0.2, 0.3, 0.5, 0.6, 0.7, 0.8, 0.9, 1].each do |rain|
      FishingForecaster.weather_forecaster = stub(:likelihood_of_rain => rain)
      likelihood_of_catch = FishingForecaster.likelihood_of_catch
      assert last_likelihood_of_catch > likelihood_of_catch if last_likelihood_of_catch
      last_likelihood_of_catch = likelihood_of_catch
    end
  end
  
  def test_likelihood_of_catch_calculated_with_sqrt_rain
    rain      = 0.5
    sqrt_rain = 0.707106781186548
    FishingForecaster.weather_forecaster = stub(:likelihood_of_rain => rain)
    Math.expects(:sqrt).with(rain).returns(sqrt_rain)
    likelihood_of_catch = FishingForecaster.likelihood_of_catch
  end

end
