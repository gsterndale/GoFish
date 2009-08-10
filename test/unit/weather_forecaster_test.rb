require File.dirname(__FILE__) + '/../test_helper'

class WeatherForecasterTest < Test::Unit::TestCase
  
  def setup
  end
  
  def teardown
  end
  
  def test_likelihood_of_rain_pop_0
    install_weather_service_uri_mocks(0)
    assert_equal 0, WeatherForecaster.likelihood_of_rain
  end
    
  def test_likelihood_of_rain_pop_100
    install_weather_service_uri_mocks(100)
    assert_equal 1.0, WeatherForecaster.likelihood_of_rain
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
