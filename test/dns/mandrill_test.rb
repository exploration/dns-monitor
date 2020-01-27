require "test_helper"

class DNS::MandrillTest < Minitest::Test
  def setup
    @api_key = 'test'
    @recipient_email = 'donald@explo.org'
  end

  def test_initialize
    mandrill = DNS::Monitor::Mandrill.new(@api_key, @recipient_email)
    assert_equal @recipient_email, mandrill.recipient_email
    assert_equal 'dns-monitor@explo.org', mandrill.from_email
  end

  def test_request
    mandrill = DNS::Monitor::Mandrill.new(@api_key, @recipient_email)
    request = mandrill.request('test body')
    assert_equal @api_key, request.dig('key')
    assert_equal 'test body', request.dig('message', 'text')
    assert_equal 'DNS Change Alert', request.dig('message', 'subject')
  end
end
