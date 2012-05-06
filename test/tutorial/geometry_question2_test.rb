require_relative 'geometry_question2'
require "test/unit"
#Donald Pomeroy 
class TestGeometryQuestion1 < Test::Unit::TestCase
 
  def test_simple
    
    assert_in_delta(314.16,Solve_question2.new().main(400),.1)    
  end
 
end
