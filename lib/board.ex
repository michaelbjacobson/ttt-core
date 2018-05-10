defmodule TicTacToe.Board do

  def new(width \\ 3) do
    1..(width * width)
    |> Enum.map(fn index -> { index, Integer.to_string(index) } end)
    |> Map.new()
    |> Map.put(:width, width)
  end

  def available_tile_indices(board) do
    board
    |> Map.delete(:width)
    |> Enum.filter(fn {index, tile_content} -> tile_is_free?(index, tile_content) end)
    |> Enum.into(%{})
    |> Map.keys()
  end

  def update(board, tile_index, player_symbol) do
    %{ board | tile_index => player_symbol }
  end

  def tile_is_free?(index, tile_content) do
    Integer.to_string(index) == tile_content
  end

  def tile_is_occupied?(index, tile_content) do
    Integer.to_string(index) != tile_content
  end

  def is_full?(board) do
    board
    |> Map.delete(:width)
    |> Enum.all?(fn {index, tile_content} -> tile_is_occupied?(index, tile_content) end)
  end

  def is_empty?(board) do
    board
    |> Map.delete(:width)
    |> Enum.all?(fn {index, tile_content} -> tile_is_free?(index, tile_content) end)
  end

  def tile_index_in_bounds?(board, tile_index) do
    Map.keys(board) |> Enum.member?(tile_index)
  end

  def corners(board) do
    width = board[:width]
    [1, width, ((width * width) - (width - 1)), (width * width)]
  end

  def rows(board) do
    board
    |> Map.delete(:width)
    |> Map.keys()
    |> Enum.chunk_every(board[:width])
  end

  def columns(board) do
    board
    |> rows()
    |> List.zip()
    |> Enum.map(&Tuple.to_list(&1))
  end

  def diagonals(board) do
    [left_to_right_diagonal(board), right_to_left_diagonal(board)]
  end

  defp left_to_right_diagonal(board) do
    board
    |> rows
    |> Enum.with_index
    |> Enum.map(fn {row, index} -> Enum.at(row, index) end)
  end

  defp right_to_left_diagonal(board) do
    board
    |> rows
    |> Enum.map(fn row -> Enum.reverse(row) end)
    |> Enum.with_index
    |> Enum.map(fn {row, index} -> Enum.at(row, index) end)
  end

end
