require 'rubygems'
require 'test/unit'
require 'mocha'
require 'ruby-debug'

require File.dirname(__FILE__) + '/../go_fish'
require File.dirname(__FILE__) + '/../fishing_forecaster'
require File.dirname(__FILE__) + '/../weather_forecaster'
  
def dummy_object
  Object.new
end
