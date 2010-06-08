require File.expand_path(File.join(File.dirname(__FILE__), "../lib", "leapyear"))

require 'test/unit'

class TestLeapYear < Test::Unit::TestCase  
  
  def setup
    @value_and_expected = {-100 => false, 400 => true, 1111 => false, 1999 => false, 2000 => true,
                            100 => false, 2002 => false, 2004 => true, 2010 => false, 2020 => true } 
  end 
 
  def test_leap_year   
    @value_and_expected.each_pair do |value, expected|      
      assert_equal expected, leap_year?(value) 
    end
  end

  def test_leap_year_edge_case_year_0_does_not_exist_so_raise_argument_error
    # This doesn't use the setup at all  It simply tests one edge case.
    # Year 0 doesn't exist in Julian or Gregorian Calendars... so my method should give an error.
    assert_raise( ArgumentError) { leap_year?(0) }
  end

  def test_other_edge_cases
    # Other edge cases are years 100, 300, 500, etc. as these years were all leap years, based on the simpler
    # rules (The year only had to be divisble by 4).  This means that technically, even 100, and -100 should be leap year.
    # Depending on the year of adoption of leap year, and adoption of the Gregorian calendar, other countries have differing
    # edge case years.
  end
end


