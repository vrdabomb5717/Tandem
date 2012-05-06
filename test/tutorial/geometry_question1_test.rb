require_relative 'geometry_question1'
require "test/unit"

#Donald Pomeroy
 
class TestGeometryQuestion1 < Test::Unit::TestCase
 
  def test_simple
    assert_equal(488, Solve_question1.new().main(10))    
  end
 
end
