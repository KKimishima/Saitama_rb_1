require "minitest/autorun"
require "./lib/convert_length"

class Convert_Length_Test < Minitest::Test
  def test_convert_length
    assert_equal 39.37, convert_length(1,from: :m,to: :in)
    assert_equal 0.25, convert_length(10,from: :in,to: :m)
  end
end
