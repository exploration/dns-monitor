require "test_helper"

class DNS::DatabaseTest < Minitest::Test
  def setup
    @filename = File.join(File.dirname(__FILE__), '..', 'test.sqlite3')
  end

  def teardown
    File.delete @filename
  end

  def test_init
    DNS::Monitor::Database.new(@filename)
    assert File.exist? @filename
  end
end
