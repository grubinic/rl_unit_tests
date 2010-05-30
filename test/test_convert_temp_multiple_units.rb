require File.expand_path(File.join(File.dirname(__FILE__), "../lib", "convert_temp_multiple_units"))
require File.expand_path(File.join(File.dirname(__FILE__), "../test", "testutils"))

require 'test/unit'

class TestConvertTempMultipleUnits < Test::Unit::TestCase
  include TestUtils
  
  def setup
    #TODO too cryptic?
    temp_sets = {
    'F' => [-508, -459.67, -58.95400, 0, 32, 77.72, 100.76,  212, 523.67],
    'C' => [-300, -273.15, -50.53, -17.7777778, 0, 25.4, 38.2, 100, 273.15],
    'K' => [-26.85, 0, 222.62, 255.372222, 273.15, 298.55, 311.35, 373.15, 546.3]}
    
    units = ['F', 'K', 'C']
    units_from_to = units.permutation(2).to_a + units.collect {|unit| [unit] * 2}   
    @tests = {}
    units_from_to.each do |unit_from, unit_to|
      @tests["#{unit_from}#{unit_to}"] = [unit_from, unit_to, temp_sets[unit_from], temp_sets[unit_to]]
    end
  end  
  
  def test_convert
    @tests.each_value do |test|
        test[2].each_with_index do |temp, i|
          assert_equal test[3][i].round(2), convert(temp, test[0], test[1]).round(2), top_level_method_call_format(:convert, temp, test[0], test[1] )
      end
    end
  end
  
  def test_convert_default_args
    tests_fc = @tests['FC']
    tests_fc[2].each_with_index do |temp, i|
      assert_equal tests_fc[3][i].round(2), convert(temp).round(2), top_level_method_call_format(:convert, temp)
    end
  end
end
