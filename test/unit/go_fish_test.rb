require File.dirname(__FILE__) + '/../test_helper'

class GoFishTest < Test::Unit::TestCase
  
  def setup
  end
  
  def teardown
    GoFish.fishing_forecaster = nil
    assert_not_nil GoFish.fishing_forecaster
  end
  
  def test_positive_response_getter
    assert_not_nil GoFish.positive_response
  end
  
  def test_negative_response_getter
    assert_not_nil GoFish.negative_response
  end
  
  def test_positive_and_negative_response_differ
    assert_not_equal GoFish.positive_response, GoFish.negative_response
  end
  
  def test_fish_today_lt_50_percent_likelihood_of_catch
    GoFish.fishing_forecaster = stub(:likelihood_of_catch => 0.49)
    assert_equal GoFish.negative_response, GoFish.fish_today?
  end
  
  def test_fish_today_eq_50_percent_likelihood_of_catch
    GoFish.fishing_forecaster = stub(:likelihood_of_catch => 0.50)
    assert_equal GoFish.positive_response, GoFish.fish_today?
  end
  
  def test_fish_today_gt_50_percent_likelihood_of_catch
    GoFish.fishing_forecaster = stub(:likelihood_of_catch => 0.51)
    assert_equal GoFish.positive_response, GoFish.fish_today?
  end
  
  def test_fishing_forecaster_default
    assert_equal FishingForecaster, GoFish.fishing_forecaster
  end
  
  def test_fishing_forecaster_getter_setter
    fishing_forecaster = dummy_object
    assert_not_equal fishing_forecaster, GoFish.fishing_forecaster
    GoFish.fishing_forecaster = fishing_forecaster
    assert_equal fishing_forecaster, GoFish.fishing_forecaster
  end
  
end
