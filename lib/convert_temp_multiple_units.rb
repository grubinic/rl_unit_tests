CONVERSIONS = { 
  'KK' => lambda { |temp| temp},
  'CK' => lambda { |temp| temp + 273.15 },
  'FK' => lambda { |temp| (temp + 459.67) * 5.0/9 },
  'KC' => lambda { |temp| temp - 273.15 },
  'KF' => lambda { |temp| temp * 9.0/5 - 459.67 } }

def convert(temp, unit_from='F', unit_to='C') 
  temp_kelvin = CONVERSIONS["#{unit_from}K"].call(temp);
  return CONVERSIONS["K#{unit_to}"].call(temp_kelvin)  
end
