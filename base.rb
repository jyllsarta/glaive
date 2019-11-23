require "dotenv/load"
require "json"
require 'net/https'
require "pry"

Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
