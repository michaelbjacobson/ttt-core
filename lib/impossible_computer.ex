defmodule TicTacToe.ImpossibleComputer do
  alias TicTacToe.{Board, Game, Rules}

  def get_index(game, _io) do
    if Board.is_empty?(game.board) do
      opening_gambit(game.board) |> Integer.to_string()
    else
      minimax(game, 0) |> Integer.to_string()
    end
  end

  defp opening_gambit(board) do
    board
    |> Board.corners()
    |> Enum.random()
  end

  defp minimax(game, depth) do
    if Rules.game_is_over?(game) do
      heuristic_value(game)
    else
      possible_moves = game.board |> Board.available_tile_indices()
      scores_map = Enum.map(possible_moves, fn index -> { index, -1 * minimax(Game.take_turn(index, game), depth + 1) } end)
                   |> Map.new()
      if (depth == 0), do: best_move(scores_map), else: best_score(scores_map)
    end
  end

  defp heuristic_value(game) do
    if Rules.game_is_won?(game), do: -1, else: 0
  end

  defp best_move(scores_map) do
    scores_map
    |> Enum.find(fn {_move, score} -> (score == best_score(scores_map)) end)
    |> elem(0)
  end

  defp best_score(scores_map) do
    scores_map
    |> Map.values()
    |> Enum.max()
  end

end
