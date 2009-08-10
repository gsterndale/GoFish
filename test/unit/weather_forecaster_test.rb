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
    <<-XML
    <?xml version="1.0"?>
    <dwml version="1.0" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.nws.noaa.gov/forecasts/xml/DWMLgen/schema/DWML.xsd">
      <head>
        <product srsName="WGS 1984" concise-name="dwmlByDay" operational-mode="official">
          <title>NOAA's National Weather Service Forecast by 24 Hour Period</title>
          <field>meteorological</field>
          <category>forecast</category>
          <creation-date refresh-frequency="PT1H">2008-10-13T17:51:31Z</creation-date>
        </product>
        <source>
          <more-information>http://www.nws.noaa.gov/forecasts/xml/</more-information>
          <production-center>Meteorological Development Laboratory<sub-center>Product Generation Branch</sub-center></production-center>
          <disclaimer>http://www.nws.noaa.gov/disclaimer.html</disclaimer>
          <credit>http://www.weather.gov/</credit>
          <credit-logo>http://www.weather.gov/images/xml_logo.gif</credit-logo>
          <feedback>http://www.weather.gov/feedback.php</feedback>
        </source>
      </head>
      <data>
        <location>
          <location-key>point1</location-key>
          <point latitude="42.36" longitude="-71.06"/>
        </location>
        <moreWeatherInformation applicable-location="point1">http://forecast.weather.gov/MapClick.php?textField1=42.36&amp;textField2=-71.06</moreWeatherInformation>
        <time-layout time-coordinate="local" summarization="24hourly">
          <layout-key>k-p24h-n2-1</layout-key>
          <start-valid-time>2008-10-13T06:00:00-04:00</start-valid-time>
          <end-valid-time>2008-10-14T06:00:00-04:00</end-valid-time>
          <start-valid-time>2008-10-14T06:00:00-04:00</start-valid-time>
          <end-valid-time>2008-10-15T06:00:00-04:00</end-valid-time>
        </time-layout>
        <time-layout time-coordinate="local" summarization="12hourly">
          <layout-key>k-p12h-n4-2</layout-key>
          <start-valid-time>2008-10-13T06:00:00-04:00</start-valid-time>
          <end-valid-time>2008-10-13T18:00:00-04:00</end-valid-time>
          <start-valid-time>2008-10-13T18:00:00-04:00</start-valid-time>
          <end-valid-time>2008-10-14T06:00:00-04:00</end-valid-time>
          <start-valid-time>2008-10-14T06:00:00-04:00</start-valid-time>
          <end-valid-time>2008-10-14T18:00:00-04:00</end-valid-time>
          <start-valid-time>2008-10-14T18:00:00-04:00</start-valid-time>
          <end-valid-time>2008-10-15T06:00:00-04:00</end-valid-time>
        </time-layout>
        <parameters applicable-location="point1">
          <temperature type="maximum" units="Fahrenheit" time-layout="k-p24h-n2-1">
            <name>Daily Maximum Temperature</name>
            <value>68</value>
            <value>71</value>
          </temperature>
          <temperature type="minimum" units="Fahrenheit" time-layout="k-p24h-n2-1">
            <name>Daily Minimum Temperature</name>
            <value>49</value>
            <value>55</value>
          </temperature>
          <probability-of-precipitation type="12 hour" units="percent" time-layout="k-p12h-n4-2">
            <name>12 Hourly Probability of Precipitation</name>
            <value>#{pop}</value>
            <value>1</value>
            <value>1</value>
            <value>15</value>
          </probability-of-precipitation>
          <weather time-layout="k-p24h-n2-1">
            <name>Weather Type, Coverage, and Intensity</name>
            <weather-conditions weather-summary="Decreasing Clouds"/>
            <weather-conditions weather-summary="Mostly Cloudy"/>
          </weather>
          <conditions-icon type="forecast-NWS" time-layout="k-p24h-n2-1">
            <name>Conditions Icons</name>
            <icon-link>http://www.nws.noaa.gov/weather/images/fcicons/bkn.jpg</icon-link>
            <icon-link>http://www.nws.noaa.gov/weather/images/fcicons/bkn.jpg</icon-link>
          </conditions-icon>
        </parameters>
      </data>
    </dwml>
    XML
  end
  
  
end
