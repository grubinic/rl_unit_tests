class Object
  def strict_to_i
    return self.to_s.match(/^\d+$/) ? self.to_i : nil
  end
end

class GameBoard
  def initialize(locations=nil)
     @no_of_guesses = 0
     set_location_cells(locations) if locations
  end
  
  def set_locations_cells(locations)
    @locations = locations    
    @board = Array.new(@locations);   
  end
  
  def check_yourself(user_guess)   
    raise ArgumentError, 'The game is finished!' if @board.empty?
    number = user_guess.strict_to_i    
    ans = @locations.include?(number) ? "Hit" : "Miss"
    @board.delete(number) 
    @no_of_guesses += 1
    puts ans
    if(@board.empty?)
      ans = "kill"
      print_stats
    end
    
    return ans;
  end 
  
  private
  def print_stats
    puts "End"
    puts "*" * 30
    puts "You took #{@no_of_guesses} guesses"
    puts "Great!" if @no_of_guesses.between?(3,4)
    puts "Not bad!" if @no_of_guesses.between?(5,7)
    puts "Having a bad day?" if @no_of_guesses > 7
    puts "*" * 30
  end 
  
end
