defmodule TicTacToe.Rules do
  alias TicTacToe.Board

  def winning_index_combos(game) do
    Board.rows(game.board) ++ Board.columns(game.board) ++ Board.diagonals(game.board)
  end

  def game_is_over?(game) do
    game_is_won?(game) || game_is_tied?(game)
  end

  def game_is_won?(game) do
    game_is_won_by?(game, game.player_1) || game_is_won_by?(game, game.player_2)
  end

  def game_is_won_by?(game, player) do
    Enum.any?(winning_index_combos(game), fn combo -> is_winning_combo?(game.board, combo, player.marker) end)
  end

  def game_is_tied?(game) do
    Board.is_full?(game.board) && !game_is_won?(game)
  end

  def is_winning_combo?(board, combo, player_marker) do
    Enum.all?(combo, fn index -> board[index] == player_marker end)
  end
end
