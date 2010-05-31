require File.expand_path(File.join(File.dirname(__FILE__), "../lib", "convert_fahr_to_cel"))
require File.expand_path(File.join(File.dirname(__FILE__), "../test", "testutils"))

require 'test/unit'



class TestConvertFahrToCel < Test::Unit::TestCase
  include TestUtils
  
  def setup
    @temp_fahr_and_expected = {-508 => -300, -459.67 => -273.15, -58.95400 => -50.53, 0 => -17.7777778,
      32 => 0, 77.72 => 25.4, 100.76 => 38.2, 212 => 100, 523.67 => 273.15 }      
  end
  
  def test_convert    
    @temp_fahr_and_expected.each do |temp_fahr, expected_temp_cel|
      assert_equal expected_temp_cel.round(2), convert(temp_fahr).round(2), top_level_method_call_format(:convert, temp_fahr)
    end
  end
  
  #TODO values below absolute zero - what's the expected result?
end



