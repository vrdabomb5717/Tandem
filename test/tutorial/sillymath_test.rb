require_relative 'sillymath'
require "test/unit"
 
class TestSillyMath < Test::Unit::TestCase
 
  def test_simple
    assert_equal(0, SillyMath.new().main(100,1000))    
  end
 
end
