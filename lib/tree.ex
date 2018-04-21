defmodule Tree do
    defstruct leafs: []

    def addLeaf(tree, value) do
        %{tree | leafs: tree.leafs ++ [value]}
    end
end