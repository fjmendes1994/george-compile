defmodule Tree do
    @moduledoc """
    Módulo de árvore que serve como componente da pilha de controle 
    """
    defstruct leafs: [], value: nil

    def new(), do: %Tree{}

    def new(value), do: %Tree{value: value}

    def add_leaf(tree, value) do
        %{tree | leafs: tree.leafs ++ [value]}
    end

    def get_leaf(tree, nth), do: Enum.at(tree.leafs, nth)

    def is_leaf(tree), do: length(tree.leafs) == 0
end