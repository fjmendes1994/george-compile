defmodule TreeTest do
    
    @moduledoc false
    
    use ExUnit.Case

    test "Criar nó com valor" do
        assert Tree.new("add") == %Tree{value: "add"}
    end

    test "Criar nó com valor e 1 folha" do
        assert Tree.new("add") |> Tree.add_leaf(1) == %Tree{value: "add", leafs: [1]}
    end
    
    test "Adicionar folha" do
        assert Tree.new |> Tree.add_leaf(1) == %Tree{leafs: [1]}
    end

    test "Adicionar 2 folhas" do
        assert Tree.new |> Tree.add_leaf(1) |> Tree.add_leaf(2) == %Tree{leafs: [1,2]}
    end

    test "Adicionar 2 folhas e pegar a primeira" do
        assert Tree.new |> Tree.add_leaf(1) |> Tree.add_leaf(2) |> Tree.get_leaf(1) == 2
    end
end