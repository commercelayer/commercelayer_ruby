require 'dotenv/load'

RSpec.shared_context "shared context" do
  let(:client) do
    Commercelayer::Client.new(
      client_id: ENV['CLIENT_ID'],
      client_secret: ENV['CLIENT_SECRET'],
      scope: ENV['SCOPE'],
      site: ENV['SITE']
    )
  end

  before do
    client.authorize!
  end

end
