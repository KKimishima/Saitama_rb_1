require "minitest/autorun"
require "./lib/deep_freezable"
require "./lib/team"
require "./lib/bank"

class DeepFreezableTest < Minitest::Test
  def test_deep_freeze
    assert DeepFreezable
    assert_equal ["ja","us","india"], Team::COUN
    assert Team::COUN.frozen?
    assert Team::COUN.all? {|con| con.frozen?}
  end
  
  def test_deep_freeze_to_hash
    assert Bank
=begin
    assert_equal(
      {"ja" => "yen","us" => "dollar","india" => "rupee"},
      Bank::CURR
    )
    
    assert_equal Bank::CURR.frozen?
    assert_equal Bank::CURR.all{|key,value| key.frozen? && value.frozen?}
=end
  end

end
