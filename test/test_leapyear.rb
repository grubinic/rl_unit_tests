require File.expand_path(File.join(File.dirname(__FILE__), "../lib", "leapyear"))
require File.expand_path(File.join(File.dirname(__FILE__), "../test", "testutils"))

require 'test/unit'

class TestLeapYear < Test::Unit::TestCase
  include TestUtils
  
  def setup
    @tests = [
      [0, 400, 444, 1111, 1999, 1900, 2000, 2004, 2010, 2020], 
      [true, true, true, false, false, false, true, true, false, true]
    ]
   
  end 
 
  def test_leap_year   
    @tests[0].each_with_index do |year, i|
      assert_equal @tests[1][i], leap_year?(year), top_level_method_call_format(:leap_year?, year)
    end
  end
end