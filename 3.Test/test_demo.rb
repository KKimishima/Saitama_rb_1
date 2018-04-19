require "minitest/autorun"

class Sample < Minitest::Test
  def test_sample
    assert_equal "RUBY" ,"ruby".upcase
  end
  
end

