require File.dirname(__FILE__) + '/../test_helper'

class WeatherForecasterTest < Test::Unit::TestCase
  
  def setup
  end
  
  def teardown
  end
  
  def test_likelihood_of_rain_pop_eq_0
    # setup Test Double: Mock Objects see below
    install_weather_service_uri_mocks(0)
    assert_equal 0, WeatherForecaster.likelihood_of_rain
  end
    
  def test_likelihood_of_rain_pop_eq_100
    # setup Test Double: Mock Objects see below
    install_weather_service_uri_mocks(100)
    assert_equal 1.0, WeatherForecaster.likelihood_of_rain
  end
  
  def test_likelihood_of_rain_pop_gt_0_lt_100
    pop = 47
    # setup Test Double: Mock Objects see below
    install_weather_service_uri_mocks(pop)
    assert_equal pop/100.0, WeatherForecaster.likelihood_of_rain
  end

private
  
  def install_weather_service_uri_mocks(pop)
    uri = mock()
    xml = weather_forecast_xml(pop)
    # setup Test Double: Mock Objects set expectation and return value
    URI.expects(:parse).returns(uri)
    # setup Test Double: Mock Objects set expectation and return value
    uri.expects(:read).returns(xml)
  end
  
  def weather_forecast_xml(pop)
    xml_file = File.open(File.join(File.dirname(__FILE__), '..', 'fixtures', 'noaa_weather.xml.erb'), 'r')
    xml_str  = ERB.new(xml_file.read, 0, "%<>").result binding
    xml_file.close
    xml_str
  end
  
end
