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

    def authorized(cached_access_token=nil)
      begin
        retries ||= 0
        Commercelayer::Resource.authorize_with = cached_access_token
        yield
      rescue JSONAPI::Consumer::Errors::NotAuthorized
        if (retries += 1) <= MAX_RETRIES
          cached_access_token = authorize!
          retry
        else
          raise
        end
      end
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
