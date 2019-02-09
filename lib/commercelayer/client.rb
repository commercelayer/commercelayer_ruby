require "oauth2"

module Commercelayer
  class Client

    MAX_RETRIES = 1

    def initialize(options={})
      @client_id = options[:client_id]
      @client_secret = options[:client_secret]
      @scope = options[:scope]
      @site = options[:site]
      Resource.site = "#{options[:site]}/api/"
    end

    def authorize!
      Resource.authorize_with = get_access_token
    end

    private
    def get_access_token(options={})
      oauth2_client = OAuth2::Client.new(@client_id, @client_secret, site: @site)
      access_token = oauth2_client.client_credentials.get_token(scope: @scope)
      access_token.token
    end

  end
end
