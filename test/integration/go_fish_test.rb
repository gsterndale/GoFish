require File.dirname(__FILE__) + '/../test_helper'

class GoFishTest < Test::Unit::TestCase
  
  def setup
  end
  
  def teardown
  end
  
  def test_fish_today_pop_eq_0
    install_weather_service_uri_mocks(0)
    assert_equal GoFish.positive_response, GoFish.fish_today?
  end
    
  def test_fish_today_pop_eq_100
    install_weather_service_uri_mocks(100)
    assert_equal GoFish.negative_response, GoFish.fish_today?
  end
  
  def test_fish_today_pop_eq_25
    install_weather_service_uri_mocks(25)
    assert_equal GoFish.positive_response, GoFish.fish_today?
  end
  
  def test_fish_today_pop_eq_26
    install_weather_service_uri_mocks(26)
    assert_equal GoFish.negative_response, GoFish.fish_today?
  end
  
private
  
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
