require_relative 'base'

class GlaiveConnector
  def self.fetch
    token = File.open(".credential"){ |f| f.read }  
    uri = URI.parse("https://www.healthplanet.jp/status/innerscan.json?access_token=#{token}&tag=6021,6022&date=0&from=20191101000000&to=20191201000000")
    
    response = Net::HTTP.get(uri)
    puts response
  rescue Errno::ENOENT
    raise "No credential file. To create, try `bundle exec ruby auth.rb` and follow instructions."
  end

  fetch if __FILE__ == $0
end
