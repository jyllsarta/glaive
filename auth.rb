require_relative 'base'

class GlaiveAuthenticator
  def self.auth
    puts self.hello_message
    print "Authorization Code:"
    auth_code = gets.chomp
    raise "code is blank" if auth_code == ""
    access_token = self.post_auth_code(auth_code)
    self.write(access_token)
    puts "All done! wrote your access token (#{access_token}) to .credential."
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

  def self.write(access_token)
    file = File.open(".credential", "w")
    file.write(access_token)
    file.close
  end

  def self.post_auth_code(auth_code)
    # POST なのにquery stringで送らないといけないの解せない設計ですよねこれ...
    uri = URI.parse("https://www.healthplanet.jp/oauth/token?client_id=#{ENV["HEALTHPLANET_CLIENT_ID"]}&client_secret=#{ENV["HEALTHPLANET_CLIENT_SECRET"]}&redirect_uri=localhost&code=#{auth_code}&grant_type=authorization_code")
    response = Net::HTTP.post(uri, "")
    JSON.parse(response.body)["access_token"] #TODO: refresh_token を使ってaccess tokenを入れ直す
  end

  auth if __FILE__ == $0
end
