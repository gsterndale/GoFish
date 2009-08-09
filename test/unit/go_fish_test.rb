require File.dirname(__FILE__) + '/../test_helper'

class GoFishTest < Test::Unit::TestCase
  
  def setup
    assert @positive_response = GoFish.positive_response
    assert @negative_response = GoFish.negative_response
    assert_not_equal @positive_response, @negative_response
  end
  
  def teardown
  end
  
  def test_lt_50_percent_fishibility
    fishibility = 0.49
    GoFish.fishing_forecaster = stub(:fishibility => fishibility)
    assert_negative_response GoFish.fish_today?
  end
  
  def test_eq_50_percent_fishibility
    fishibility = 0.50
    GoFish.fishing_forecaster = stub(:fishibility => fishibility)
    assert_positive_response GoFish.fish_today?
  end
  
  def test_gt_50_percent_fishibility
    fishibility = 0.51
    GoFish.fishing_forecaster = stub(:fishibility => fishibility)
    assert_positive_response GoFish.fish_today?
  end
  
  def test_fishing_forecaster_getter_setter
    fishing_forecaster = dummy_object
    assert_not_equal fishing_forecaster, GoFish.fishing_forecaster
    GoFish.fishing_forecaster = fishing_forecaster
    assert_equal fishing_forecaster, GoFish.fishing_forecaster
  end
  
  def test_positive_response_getter_setter
    response = 'yes'
    assert_not_equal response, GoFish.positive_response
    GoFish.positive_response = response
    assert_equal response, GoFish.positive_response
  end
  
  def test_negative_response_getter_setter
    response = 'no'
    assert_not_equal response, GoFish.negative_response
    GoFish.negative_response = response
    assert_equal response, GoFish.negative_response
  end
  
private
  
  def dummy_object
    Object.new
  end
  
  def assert_positive_response(response)
    assert_equal @positive_response, response
  end
  
  def assert_negative_response(response)
    assert_equal @negative_response, response
  end
  
end
