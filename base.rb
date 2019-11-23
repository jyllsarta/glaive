require "dotenv/load"
require "json"

Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
