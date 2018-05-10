defmodule TicTacToe.Human do

  def get_index(_game, input) do
    input.gets("> ") |> String.trim()
  end

end
