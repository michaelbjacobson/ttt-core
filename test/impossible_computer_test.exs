defmodule ImpossibleComputerTest do
  use ExUnit.Case
  alias TicTacToe.ImpossibleComputer

  @player_1 TicTacToe.Player.new("X", ImpossibleComputer)
  @player_2 TicTacToe.Player.new("O", Human)
  @empty_board %{1 => "1", 2 => "2", 3 => "3", 4 => "4", 5 => "5", 6 => "6", 7 => "7", 8 => "8", 9 => "9", :width => 3}
  @corner_occupied_board %{1 => "1", 2 => "2", 3 => "3", 4 => "4", 5 => "5", 6 => "6", 7 => "7", 8 => "8", 9 => "O", :width => 3}
  @win_available_board %{1 => "X", 2 => "2", 3 => "X", 4 => "O", 5 => "O", 6 => "6", 7 => "7", 8 => "8", 9 => "9", :width => 3}
  @loss_risk_board %{1 => "1", 2 => "2", 3 => "3", 4 => "4", 5 => "X", 6 => "6", 7 => "7", 8 => "O", 9 => "O", :width => 3}
  @triangle_risk_board %{1 => "X", 2 => "2", 3 => "3", 4 => "4", 5 => "O", 6 => "6", 7 => "7", 8 => "8", 9 => "O", :width => 3}
  @encirclement_risk_board %{1 => "O", 2 => "2", 3 => "3", 4 => "4", 5 => "X", 6 => "6", 7 => "7", 8 => "8", 9 => "O", :width => 3}
  @arrowhead_risk_board %{1 => "1", 2 => "2", 3 => "3", 4 => "4", 5 => "5", 6 => "6", 7 => "7", 8 => "O", 9 => "9", :width => 3}

  test "ImpossibleComputer.get_index/2 picks a corner if the board is empty" do
    game = TicTacToe.Game.new(@empty_board, @player_1, @player_2)
    expected = [1, 3, 7, 9]
    actual = ImpossibleComputer.get_index(game, :io) |> String.to_integer()
    assert Enum.member?(expected, actual)
  end

  test "ImpossibleComputer.get_index/2 plays to the center tile if a corner is occupied by opponent" do
    game = TicTacToe.Game.new(@corner_occupied_board, @player_1, @player_2)
    expected = 5
    actual = ImpossibleComputer.get_index(game, :io) |> String.to_integer()
    assert actual == expected
  end

  test "ImpossibleComputer.get_index/2 will choose a winning index if possible" do
    game = TicTacToe.Game.new(@win_available_board, @player_1, @player_2)
    expected = 2
    actual = ImpossibleComputer.get_index(game, :io) |> String.to_integer()
    assert actual == expected
  end

  test "ImpossibleComputer.get_index/2 will block an opponent victory if possible" do
    game = TicTacToe.Game.new(@loss_risk_board, @player_1, @player_2)
    expected = 7
    actual = ImpossibleComputer.get_index(game, :io) |> String.to_integer()
    assert actual == expected
  end

  test "ImpossibleComputer.get_index/2 will prevent opponent from employing the triangle fork strategy" do
    game = TicTacToe.Game.new(@triangle_risk_board, @player_1, @player_2)
    expected = 3
    actual = ImpossibleComputer.get_index(game, :io) |> String.to_integer()
    assert actual == expected
  end

  test "ImpossibleComputer.get_index/2 will prevent opponent from employing the arrowhead fork strategy" do
    game = TicTacToe.Game.new(@arrowhead_risk_board, @player_1, @player_2)
    expected = 2
    actual = ImpossibleComputer.get_index(game, :io) |> String.to_integer()
    assert actual == expected
  end

  test "ImpossibleComputer.get_index/2 will prevent opponent from employing the encirclement fork strategy" do
    game = TicTacToe.Game.new(@encirclement_risk_board, @player_1, @player_2)
    expected = 2
    actual = ImpossibleComputer.get_index(game, :io) |> String.to_integer()
    assert actual == expected
  end

end
