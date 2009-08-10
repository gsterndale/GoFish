require File.dirname(__FILE__) + '/../test_helper'

class GoFishTest < Test::Unit::TestCase
  
  def setup
  end
  
  def teardown
  end
  
  def test_fish_today_pop_eq_0
    install_weather_service_uri_mocks(0)
    assert_positive_response GoFish.fish_today?
  end
    
  def test_fish_today_pop_eq_100
    install_weather_service_uri_mocks(100)
    assert_negative_response GoFish.fish_today?
  end
  
  def test_fish_today_pop_eq_25
    pop = 25
    install_weather_service_uri_mocks(pop)
    assert_positive_response GoFish.fish_today?
  end
  
  def test_fish_today_pop_eq_26
    pop = 26
    install_weather_service_uri_mocks(pop)
    assert_negative_response GoFish.fish_today?
  end
  
private
  
  def assert_positive_response(response)
    assert_equal GoFish.positive_response, response
  end
  
  def assert_negative_response(response)
    assert_equal GoFish.negative_response, response
  end
  
  def install_weather_service_uri_mocks(pop)
    uri = mock()
    xml = weather_forecast_xml(pop)
    URI.expects(:parse).returns(uri)
    uri.expects(:read).returns(xml)
  end
  
  def weather_forecast_xml(pop)
    xml_file = File.open(File.join(File.dirname(__FILE__), '..', 'fixtures', 'noaa_weather.xml.erb'), 'r')
    xml_str  = ERB.new(xml_file.read, 0, "%<>").result binding
    xml_file.close
    xml_str
  end
  
end
