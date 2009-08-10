require 'rubygems'
require 'uri'
require 'open-uri'
require 'hpricot'

class ServiceError < RuntimeError; end

class WeatherForecaster
  
  # Thanks Umbrella Today!
  def self.likelihood_of_rain
    doc = Hpricot::XML(weather_xml)
    pop = (doc/'probability-of-precipitation'/'value').first.innerHTML.to_f
    pop / 100.0
  rescue Timeout::Error, 
         Errno::EINVAL, 
         Errno::ECONNRESET, 
         EOFError,
         Net::HTTPBadResponse, 
         Net::HTTPHeaderSyntaxError,
         Net::ProtocolError => e
    service_error = ServiceError.new
    service_error.set_backtrace(e.backtrace)
    raise service_error
  end

protected

  def self.weather_xml
    service_uri.read
  end
  
  def self.service_uri
    URI.parse(service_url)
  end
  
  def self.service_url
    time = Time.now.strftime("%Y-%m-%d")
    "http://www.weather.gov/forecasts/xml/sample_products/browser_interface/ndfdBrowserClientByDay.php?&format=24+hourly&numDays=2&lat=42.34577&lon=-71.073875&startDate=#{time}"
  end
  
end