def leap_year?(year)
  case year
  when 0
    raise ArgumentError, "Year 0 doesn't exist in Gregorian or Julian Calendars." 
  else
    year % 400 == 0 || (year % 100 != 0 && year % 4 == 0)
  end
end


