require File.dirname(__FILE__) + '/../test_helper'

class FishingForecasterTest < Test::Unit::TestCase
  
  def setup
  end
  
  def teardown
    # teardown Test Double: remove Test Stub via direct injection
    FishingForecaster.weather_forecaster = nil
    assert_not_nil FishingForecaster.weather_forecaster
  end
  
  def test_fishing_forecaster_default
    assert_not_nil FishingForecaster.weather_forecaster
  end
  
  def test_weather_forecaster_getter_setter
    # setup Test Double: Dummy Object via direct injection
    weather_forecaster = dummy_object
    assert_not_equal weather_forecaster, FishingForecaster.weather_forecaster
    FishingForecaster.weather_forecaster = weather_forecaster
    assert_equal weather_forecaster, FishingForecaster.weather_forecaster
  end
  
  def test_likelihood_of_catch_0_likelihood_of_rain
    # setup Test Double: Test Stub via direct injection
    FishingForecaster.weather_forecaster = stub(:likelihood_of_rain => 0)
    assert_equal 1.0, FishingForecaster.likelihood_of_catch
  end
  
  def test_likelihood_of_catch_1_likelihood_of_rain
    # setup Test Double: Test Stub via direct injection
    FishingForecaster.weather_forecaster = stub(:likelihood_of_rain => 1)
    assert_equal 0.0, FishingForecaster.likelihood_of_catch
  end
  
  def test_likelihood_of_catch_inversely_related_to_likelihood_of_rain
    last_likelihood_of_catch = nil
    [0, 0.1, 0.2, 0.3, 0.5, 0.6, 0.7, 0.8, 0.9, 1].each do |rain|
      # setup Test Double: Test Stub via direct injection
      FishingForecaster.weather_forecaster = stub(:likelihood_of_rain => rain)
      likelihood_of_catch = FishingForecaster.likelihood_of_catch
      assert last_likelihood_of_catch > likelihood_of_catch if last_likelihood_of_catch
      last_likelihood_of_catch = likelihood_of_catch
    end
  end
  
  # Verifying method of calculation (sqrt) requries visibility into SUT implementation details
  def test_likelihood_of_catch_calculated_with_sqrt_rain
    rain      = 0.5
    sqrt_rain = 0.707106781186548
    # setup Test Double: Test Stub via direct injection
    FishingForecaster.weather_forecaster = stub(:likelihood_of_rain => rain)
    # setup Test Double: Mock Object, set expectation with specific arguements and return value
    Math.expects(:sqrt).with(rain).returns(sqrt_rain)
    likelihood_of_catch = FishingForecaster.likelihood_of_catch
    # Notice that verification (assertions) are not necessary.
    # If the mock object's expectations are not met, it will cause the test to fail.
  end

private

  def dummy_object
    Object.new
  end
  
end
