require File.expand_path(File.join(File.dirname(__FILE__), "../lib", "gameboard"))

require 'test/unit'


class Object
  def test_game_board_format
    self.to_s.downcase
  end
end

class TestGameboard < Test::Unit::TestCase
  def test_game_board_general_tests    
    run_gameboard_tests(@general_tests)
  end
  
  def test_same_correct_guess_three_times
    run_gameboard_tests(@same_correct_guess_tests)
  end
  
  def test_returns_miss_on_invalid_input
    location_cells = [0,1,2]
    guesses = ["X","0.5", 0.5]
    game_board = create_game_board(location_cells)
    guesses.each_with_index do |user_guess, guess_index|
       assert_equal :miss.test_game_board_format, 
        game_board.check_yourself(user_guess).test_game_board_format,
        format_assert_msg(game_board, location_cells, guesses, guess_index)  
    end

  end
  
  #testing if location_cells are unmodified after the game 
  def test_location_cells_not_modified_after_game_finished
    location_cells = [2,3,4]
    location_cells_copy = Array.new(location_cells)
    run_three_guess_game(location_cells)
    assert_equal location_cells_copy, location_cells
  end
  
  #assuming the method should raise an error on calls after kill
  def test_raise_argument_error_after_kill
    location_cells = [1,2,3]    
    game_board = run_three_guess_game(location_cells)   
    assert_raise(ArgumentError) {game_board.check_yourself(location_cells[0])}
  end 
 
  #message to help identify the problem on assert failure
  def format_assert_msg(game_board, location_cells, guesses, guess_index)
      "Locations: %s\nGuesses: %s\nGuess: index=%s, number=%s" % [location_cells,
    guesses,
    guess_index, 
    guesses[guess_index]]
  end  
  
  def run_gameboard_tests(test_data)
    test_data.each do |location_cells, guesses, expected_results|      
      game_board = create_game_board(location_cells)   
      guesses.each_with_index do |user_guess, guess_index|
        assert_equal expected_results[guess_index].test_game_board_format, 
        game_board.check_yourself(user_guess).test_game_board_format,
        format_assert_msg(game_board, location_cells, guesses, guess_index)         
      end
    end
  end
  
  def run_three_guess_game(location_cells)    
    game_board = create_game_board(location_cells)
    location_cells.each do |number|
      game_board.check_yourself(number)
    end
    return game_board
  end
  
  def create_game_board(location_cells)
    game_board = GameBoard.new
    game_board.set_locations_cells(location_cells)
    return game_board
  end
  
  def setup   
  
    @same_correct_guess_tests = [
    [[0,1,2], [0,0,0], [:hit,:hit, :hit]],
    [[1,2,3], [1,3,3,0,3], [:hit,:hit,:hit,:miss,:hit]],
    [[2,3,4], [6,4,4,4,4,6], [:miss,:hit,:hit,:hit,:hit,:miss]]  
    ]
    @general_tests = [
    [[0,1,2], [2,3,1,4,5,6,7,0], [:hit,:miss,:hit,:miss,:miss,:miss,:miss,:kill]],
    [[1,2,3], [6,3,3,0,2,1], [:miss,:hit,:hit,:miss,:hit,:kill]],
    [[2,3,4], [2,1,3,4], [:hit,:miss,:hit,:kill]],
    [[3,4,5], [0,1,2,3,4,4,5], [:miss,:miss,:miss,:hit,:hit,:hit,:kill]],
    [[4,5,6], [6,5,3,5,6,4], [:hit,:hit,:miss,:hit,:hit,:kill]]
    ]
  end 
end
