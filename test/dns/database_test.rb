require "test_helper"

class DNS::DatabaseTest < Minitest::Test
  def setup
    @filename = File.join(File.dirname(__FILE__), '..', 'test.sqlite3')
    @db = DNS::Monitor::Database.new(@filename)
  end

  def teardown
    File.delete @filename
  end

  def test_init
    assert File.exist? @filename
  end

  def test_empty_diff
    assert_empty @db.diff('{}', '{}') 
  end

  def test_diff_single_value
    assert_equal({'a' => 'test1'}, @db.diff(
      {'b' => 'test2'}.to_json,
      {'a' => 'test1', 'b' => 'test2'}.to_json
    ))
  end

  def test_diff_value_order
    assert_equal({}, @db.diff(
      {'b' => 'test2', 'a' => 'test1'}.to_json,
      {'a' => 'test1', 'b' => 'test2'}.to_json
    ))
  end

  def test_changed_value
    assert_equal({'b' => 'changed'}, @db.diff(
      {'b' => 'test2', 'a' => 'test1'}.to_json,
      {'a' => 'test1', 'b' => 'changed'}.to_json
    ))
  end

  def test_diff_nested_changed_values
    assert_equal({'a' => {'c' => 'changed'}}, @db.diff(
      {'b' => 'test2', 'a' => {'c' => 'test1'}}.to_json,
      {'b' => 'test2', 'a' => {'c' => 'changed'}}.to_json
    ))
  end

  def test_removing_noisy_keys
    noisy_changes = {:events=> [{
      :eventAction=>"last update of RDAP database",
      :eventDate=>"2020-01-30T13:00:06+0000Z"
    }]}
    assert_empty @db.filter_noisy_keys(noisy_changes)

    legit_changes = {:events=> [
      {:eventAction=>"registration", :eventDate=>"2011-06-11T11:46:01+0000Z"},
      {:eventAction=>"expiration", :eventDate=>"2021-06-11T11:46:01+0000Z"},
      {:eventDate=>"2020-01-30T14:09:40+0000Z", :eventAction=>"last update of RDAP database"},
      {:eventDate=>"2020-01-27T00:51:58+0000Z", :eventAction=>"last changed"}
    ]}
    refute_empty @db.filter_noisy_keys(legit_changes)
    assert_equal 3, @db.filter_noisy_keys(legit_changes)[:events].length
  end
end
