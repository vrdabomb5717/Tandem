require_relative 'geometry_question3'
require "test/unit"
 
class TestGeometryQuestion3 < Test::Unit::TestCase
 
  def test_simple
    assert_equal(184, Solve_question3.new().main(92,2))    
  end
 
end
