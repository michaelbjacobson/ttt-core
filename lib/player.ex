defmodule TicTacToe.Player do

  defstruct [
    :marker,
    :module,
    :input
  ]

  def new(marker, module, input \\ IO) do
    %TicTacToe.Player{ marker: marker, module: module, input: input }
  end

  def get_move(player, game) do
    player.module.get_index(game, player.input)
  end

end
