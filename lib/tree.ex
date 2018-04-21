defmodule Tree do
    defstruct leafs: [], value: nil

    def new(), do: %Tree{}

    def new(value), do: %Tree{value: value}

    def add_leaf(tree, value) do
        %{tree | leafs: tree.leafs ++ [value]}
    end

    def get_leaf(tree, nth), do: Enum.at(tree.leafs, nth)
end