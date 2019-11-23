require_relative 'base'

class GlaiveAuthenticator
  def self.auth
    puts self.hello_message
    print "Authorization Code:"
    auth_code = gets.chomp
    raise "code is blank" if auth_code == ""
    self.write(auth_code)
    puts "All done! wrote your auth code (#{auth_code}) to .credential."
  end

  def self.hello_message
    message = <<"EOS"
    ***************************************************************************
      Welcome to Glaive Auth app!
      1. paste this URL to your browser.
      URL: %s
      2. hit accept button in that page
      3. your health planet access code will show in your browser
      (access code will also put to .credential, glaive uses this)
    ***************************************************************************
EOS
    message % self.uri
  end

  def self.uri
    "https://www.healthplanet.jp/oauth/auth?client_id=#{ENV["HEALTHPLANET_CLIENT_ID"]}&response_type=code&redirect_uri=http://localhost&scope=#{ENV["HEALTHPLANET_AUTH_SCOPE"]}"
  end

  def self.write(auth_code)
    file = File.open(".credential", "w")
    file.write(auth_code)
    file.close
  end

  auth if __FILE__ == $0
end
