require "test_helper"

class DNS::MonitorTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::DNS::Monitor::VERSION
  end
end
