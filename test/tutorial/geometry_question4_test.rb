require_relative 'geometry_question4'
require "test/unit"
#Donald Pomeroy 
class TestGeometryQuestion4 < Test::Unit::TestCase
 
  def test_simple
    assert_equal(48, Solve_question4.new().main(32,.25))    
  end
 
end
