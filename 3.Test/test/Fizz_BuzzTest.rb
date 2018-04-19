require "minitest/autorun"
require "./lib/fizz_buzz"

class Fizz_BuzzTest < Minitest::Test
  def test_fizz_buzz
    assert_equal "1" , fizz_buzz(1)
    assert_equal "FIZZ_BUZZ" , fizz_buzz(15)
    assert_equal "FIZZ" , fizz_buzz(10)
    assert_equal "BUZZ" , fizz_buzz(5)
  end
end


