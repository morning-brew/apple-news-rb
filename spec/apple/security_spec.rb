require 'spec_helper'

describe AppleNewsClient::Security do

  it 'creates an HMAC auth header' do
    config = AppleNewsClient::Configuration.new(
      api_key_id:     'testkey',
      api_key_secret: 'dGVzdHNlY3JldA=='
    )
    security = AppleNewsClient::Security.new('GET', 'http://foo.com/', config)
    expect(security.authorization).to match(/^HHMAC; key=#{config.api_key_id}; signature=(.+); date=(.+)$/)
  end

end
