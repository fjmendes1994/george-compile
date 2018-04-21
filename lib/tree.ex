defmodule Tree do
    defstruct leafs: []

    def new, do: %Tree{}

    def addLeaf(tree, value) do
        %{tree | leafs: tree.leafs ++ [value]}
    end
end