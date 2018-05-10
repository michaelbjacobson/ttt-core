defmodule TicTacToe.EasyComputer do
  alias TicTacToe.Board

  def get_index(game, _io) do
    Process.sleep(1000)
    Board.available_tile_indices(game.board) |> Enum.random()
    |> Integer.to_string()
  end

end
