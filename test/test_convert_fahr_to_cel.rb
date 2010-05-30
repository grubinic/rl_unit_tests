require File.expand_path(File.join(File.dirname(__FILE__), "../lib", "convert_fahr_to_cel"))
require File.expand_path(File.join(File.dirname(__FILE__), "../test", "testutils"))

require 'test/unit'



class TestConvertFahrToCel < Test::Unit::TestCase
  include TestUtils
  
  def setup
    @tests = [
      [-508, -459.67, -58.95400, 0, 32, 77.72, 100.76,  212, 523.67], 
      [-300, -273.15, -50.53, -17.7777778, 0, 25.4, 38.2, 100, 273.15]
    ]
  end
  
  def test_convert    
    @tests[0].each_with_index do |temp_fahr, i|
      assert_equal @tests[1][i].round(2), convert(temp_fahr).round(2), top_level_method_call_format(:convert, temp_fahr)
    end
  end
end



