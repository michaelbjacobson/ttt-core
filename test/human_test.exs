defmodule HumanTest do
  use ExUnit.Case
  alias TicTacToe.Human

  defmodule MockIO do
    def gets("> "), do: "1\n"
  end

	test "Human.get_index/2 sends a prompt to the given io module and returns the input as an integer" do
		expected = "1"
    actual = Human.get_index(:available_tile_indices, MockIO)
    assert actual == expected
	end

end
