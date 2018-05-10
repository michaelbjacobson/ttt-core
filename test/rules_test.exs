defmodule RulesTest do
  use ExUnit.Case
  alias TicTacToe.Rules
	alias TicTacToe.Game
	alias TicTacToe.Player

	@blank_game_board %{1 => "1", 2 => "2", 3 => "3", 4 => "4", 5 => "5", 6 => "6", 7 => "7", 8 => "8", 9 => "9", :width => 3}
	@game_board_won_by_x %{1 => "1", 2 => "2", 3 => "X", 4 => "4", 5 => "X", 6 => "6", 7 => "X", 8 => "8", 9 => "9", :width => 3}
	@tied_game_board %{1 => "X", 2 => "X", 3 => "O", 4 => "O", 5 => "O", 6 => "X", 7 => "X", 8 => "X", 9 => "O", :width => 3}

	test "Rules.winning_index_combos/0 returns a two dimensional list containing all the winning combos" do
		expected = [
	    [1, 2, 3], [4, 5, 6], [7, 8, 9],
	    [1, 4, 7], [2, 5, 8], [3, 6, 9],
	    [1, 5, 9], [3, 5, 7]
	  ]
		actual = Rules.winning_index_combos(Game.new(@blank_game_board, Player.new("X", :human), Player.new("O", :human)))
		assert actual == expected
	end

	test "Rules.is_winning_combo?/3 returns a boolean indicating whether the indicated board tiles all contain the given marker" do
	  args = [
	    { [1,2,3], false },
	    { [3,5,7], true }
	  ]
	  for {arg, expected_result} <- args do
	    assert Rules.is_winning_combo?(@game_board_won_by_x, arg, "X") == expected_result
	  end
	end

	test "Rules.game_is_won_by?/2 returns a boolean indicating whether the game has been won by the given player" do
		test_game = Game.new(@game_board_won_by_x, Player.new("X", :human), Player.new("O", :human))
		assert Rules.game_is_won_by?(test_game, test_game.player_1) == true
		assert Rules.game_is_won_by?(test_game, test_game.player_2) == false
	end

	test "Rules.game_is_won?/1 returns a boolean indicating whether the given game has been won by either player" do
		test_game_won = Game.new(@game_board_won_by_x, Player.new("X", :human), Player.new("O", :human))
		test_game_not_yet_won = Game.new(@blank_game_board, Player.new("X", :human), Player.new("O", :human))
		assert Rules.game_is_won?(test_game_won) == true
		assert Rules.game_is_won?(test_game_not_yet_won) == false
	end

	test "Rules.game_is_tied?/1 returns a boolean indicating whether or not the given game is tied" do
		test_game_tied = Game.new(@tied_game_board, Player.new("X", :human), Player.new("O", :human))
		test_game_not_tied = Game.new(@blank_game_board, Player.new("X", :human), Player.new("O", :human))
		assert Rules.game_is_tied?(test_game_tied) == true
		assert Rules.game_is_tied?(test_game_not_tied) == false
	end

	test "Rules.game_is_over?/1 returns a boolean indicating whether the given game is over or not" do
		test_game_blank = Game.new(@blank_game_board, Player.new("X", :human), Player.new("O", :human))
		test_game_tied = Game.new(@tied_game_board, Player.new("X", :human), Player.new("O", :human))
		test_game_won = Game.new(@game_board_won_by_x, Player.new("X", :human), Player.new("O", :human))
		assert Rules.game_is_over?(test_game_blank) == false
		assert Rules.game_is_over?(test_game_tied) == true
		assert Rules.game_is_over?(test_game_won) == true
	end

end
