require File.expand_path(File.join(File.dirname(__FILE__), "../lib", "gameboard"))
require File.expand_path(File.join(File.dirname(__FILE__), "../test", "testutils"))

require 'test/unit'


class Object
  def test_game_board_format
    self.to_s.downcase
  end
end

class TestGameboard < Test::Unit::TestCase
  include TestUtils
  
  def test_game_board    
    @tests[:locations].each_with_index do |location_cells, location_cells_index|
      
      game_board = GameBoard.new
      game_board.set_locations_cells(location_cells)
      guesses = @tests[:guesses][location_cells_index]
      
      guesses.each_with_index do |user_guess, guess_index|
        assert_equal @tests[:results][location_cells_index][guess_index].test_game_board_format, 
        game_board.check_yourself(user_guess).test_game_board_format,
        format_assert_msg(game_board, location_cells, guesses, guess_index, user_guess)         
      end      
    
    end
  end
  
  def format_assert_msg(game_board, location_cells, guesses, guess_index, user_guess)
      "Locations: %s\nGuesses: %s\nGuess: index=%s, number=%s\n%s" % [location_cells,
    guesses,
    guess_index, 
    user_guess, 
    method_call_format(game_board, :check_yourself, user_guess)]
  end
  
  def setup
    @tests = { :locations => [[0,1,2], [1,2,3], [2,3,4], [3,4,5], [4,5,6]],
      :guesses => [[2,3,1,4,5,6,7,"0"], [3,3,3,0,2,1],[2,"X",3,4], [0,1,2,3,4,4,5], [6,5,3,5,6,4]],
      :results => [[:Hit,:Miss,:Hit,:Miss,:Miss,:Miss,:Miss,:Kill], [:Hit,:Hit,:Hit,:Miss,:Hit,:Kill],
      [:Hit,:Miss,:Hit,:Kill], [:Miss,:Miss,:Miss,:Hit,:Hit,:Hit,:Kill],  [:Hit,:Hit,:Miss,:Hit,:Hit,:Kill]] }
  end 
end