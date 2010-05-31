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
    @tests.each do |location_cells, guesses, expected_results|      
      game_board = GameBoard.new
      game_board.set_locations_cells(location_cells)
      guesses.each_with_index do |user_guess, guess_index|
        assert_equal expected_results[guess_index].test_game_board_format, 
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
    @tests = [
      [[0,1,2], [2,3,1,4,5,6,7,"0"], [:Hit,:Miss,:Hit,:Miss,:Miss,:Miss,:Miss,:Kill]],
      [[1,2,3], [3,3,3,0,2,1], [:Hit,:Hit,:Hit,:Miss,:Hit,:Kill]],
      [[2,3,4], [2,"X",3,4], [:Hit,:Miss,:Hit,:Kill]],
      [[3,4,5], [0,1,2,3,4,4,5], [:Miss,:Miss,:Miss,:Hit,:Hit,:Hit,:Kill]],
      [[4,5,6], [6,5,3,5,6,4], [:Hit,:Hit,:Miss,:Hit,:Hit,:Kill]]
    ]
  end 
end

#TODO refactor to specific tests, for example: test_same_guess_three_times, test_guess_after_kill, 
#test_zero_guess, test_invalid_guess ?
#TODO refactor test data model ?