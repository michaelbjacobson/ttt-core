defmodule BoardTest do
  use ExUnit.Case
  alias TicTacToe.Board

  test "Board.new/0 returns a blank board" do
    expected = %{
      1 => "1", 2 => "2", 3 => "3",
      4 => "4", 5 => "5", 6 => "6",
      7 => "7", 8 => "8", 9 => "9",
      :width => 3
    }
    actual = Board.new()
    assert actual == expected
  end

  test "Board.update/3 returns a new board, marked at the indicated index" do
    expected = %{
      1 => "1", 2 => "2", 3 => "3",
      4 => "4", 5 => "X", 6 => "6",
      7 => "7", 8 => "8", 9 => "9",
      :width => 3
    }
    actual = Board.new() |> Board.update(5, "X")
    assert actual == expected
  end

  test "Board.is_empty?/1 returns a boolean indicating whether the given board is empty" do
    args = [
      { Board.new(), true },
      { Board.new() |> Board.update(1, "X"), false }
    ]
    for {arg, expected_result} <- args do
      assert Board.is_empty?(arg) == expected_result
    end
  end

  test "Board.is_full?/1 returns a boolean indicating whether the given board is full" do
    test_board = %{1 => "1", 2 => "X", 3 => "O", 4 => "X", 5 => "O", 6 => "X", 7 => "O", 8 => "X", 9 => "O", :width => 3}
    args = [
      { Board.new(), false },
      { test_board, false },
      { Board.update(test_board, 1, "O"), true }
    ]
    for {arg, expected_result} <- args do
      assert Board.is_full?(arg) == expected_result
    end
  end

  test "Board.tile_is_occupied?/2 returns a boolean indicating whether the given tile is occupied" do
    args = [
      { {1, "1"}, false },
      { {1, "X"}, true }
    ]
    for {arg, expected_result} <- args do
      assert Board.tile_is_occupied?(elem(arg, 0), elem(arg, 1)) == expected_result
    end
  end

  test "Board.tile_is_free?/2 returns a boolean indicating whether the given tile is free" do
    args = [
      { {1, "1"}, true },
      { {1, "O"}, false }
    ]
    for {arg, expected_result} <- args do
      assert Board.tile_is_free?(elem(arg, 0), elem(arg, 1)) == expected_result
    end
  end

  test "Board.available_tile_indices/1 returns a list of all available tile indices for the given board" do
    expected = [2, 3, 4, 5, 6, 7, 8]
    actual = Board.new()
             |> Board.update(1, "X")
             |> Board.update(9, "O")
             |> Board.available_tile_indices()
    assert actual == expected
  end

  test "Board.tile_index_in_bounds?/2 returns a boolean indicating whether or not the given tile index is in bounds of the given board" do
    args = [
      { -1, false },
      { 5, true },
      { 9, true },
      { 10, false }
    ]
    for {arg, expected_result} <- args do
      assert Board.tile_index_in_bounds?(Board.new(), arg) == expected_result
    end
  end

end
