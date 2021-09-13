require "digest/sha1"
require "base64"
require "openssl"
require "json"
require "erb"
require "uri"
require "net/http"

class WhaleWisdom
  def initialize(secret_key:, shared_key:)
    @secret_key = secret_key
    @shared_key = shared_key
  end

  def request(args)
    uri = URI endpoint(args)
    puts "> #{uri}"
    res = Net::HTTP.get_response(uri)
    puts "< #{res.body}"
    res.body if res.is_a?(Net::HTTPSuccess)
  end

  private

    def timestamp
      @timestamp ||= Time.now.utc.strftime('%Y-%m-%dT%H:%M:%SZ')
    end

    def endpoint(args)
      "https://whalewisdom.com/shell/command.json?args=#{encode(args)}&api_shared_key=#{@shared_key}&api_sig=#{signature(args)}&timestamp=#{encode(timestamp)}"
    end

    def signature(args)
      hmac = OpenSSL::HMAC.digest(
        OpenSSL::Digest.new('sha1'), 
        @secret_key, 
        args + "\n" + timestamp)

      Base64.strict_encode64(hmac)
    end

    def encode(str)
      ERB::Util.url_encode str
    end
end
