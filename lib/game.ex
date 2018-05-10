defmodule TicTacToe.Game do
  alias TicTacToe.Board
  alias TicTacToe.Rules

  defstruct [
    :board,
    :player_1,
    :player_2,
    :current_player,
    :is_over?
  ]

  def new(board, player_1, player_2) do
    %TicTacToe.Game {
      board: board,
      player_1: player_1,
      player_2: player_2,
      current_player: player_1,
      is_over?: false
    }
  end

  def take_turn(move_index, game) do
    game
    |> update_board(move_index)
    |> switch_players()
    |> assert_is_over()
  end

  def switch_players(game) do
    cond do
      game.current_player == game.player_1 -> %{ game | current_player: game.player_2}
      game.current_player == game.player_2 -> %{ game | current_player: game.player_1}
    end
  end

  def update_board(game, move_index) do
    updated_board = Board.update(game.board, move_index, game.current_player.marker)
    %{ game | board: updated_board }
  end

  def assert_is_over(game) do
    %{ game | is_over?: Rules.game_is_over?(game) }
  end

end
