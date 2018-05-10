defmodule EasyComputerTest do
  use ExUnit.Case
  alias TicTacToe.EasyComputer

	test "Computer.get_index/2 returns a random integer from the given list of available indices" do
    mock_game = %{board: %{1 => "1", 2 => "2", 3 => "3", 4 => "4", 5 => "5", 6 => "6", 7 => "7", 8 => "8", 9 => "9"}}
    available_tile_indices = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    computer_move = EasyComputer.get_index(mock_game, :io)
    assert Enum.member?(available_tile_indices, String.to_integer(computer_move)) == true
	end

end
