def fizz_buzz(n)
  if n % 15 == 0
    "FIZZ_BUZZ"
  elsif n  % 10 == 0
    "FIZZ"
  elsif n % 5 == 0
    "BUZZ"
  else
    n.to_s
  end
end

=begin
require "minitest/autorun"

class Fizz_BuzzTest < Minitest::Test
  def test_fizz_buzz
    assert_equal "1" , fizz_buzz(1)
    assert_equal "FIZZ_BUZZ" , fizz_buzz(15)
    assert_equal "FIZZ" , fizz_buzz(10)
    assert_equal "BUZZ" , fizz_buzz(5)
  end
end
=end

=begin
p fizz_buzz("hoge")
p fizz_buzz(1)
p fizz_buzz(5)
p fizz_buzz(10)
p fizz_buzz(15)
=end
