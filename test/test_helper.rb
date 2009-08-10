require 'rubygems'
require 'test/unit'
require 'mocha'
require 'erb'
require 'ruby-debug'

require File.dirname(__FILE__) + '/../lib/go_fish'
require File.dirname(__FILE__) + '/../lib/fishing_forecaster'
require File.dirname(__FILE__) + '/../lib/weather_forecaster'
  
def dummy_object
  Object.new
end
