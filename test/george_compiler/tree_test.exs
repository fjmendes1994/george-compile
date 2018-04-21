defmodule TreeTest do
    
    @moduledoc false
    
    use ExUnit.Case

    test "Adicionar folha" do
        assert Tree.new |> Tree.addLeaf(1) == %Tree{leafs: [1]}
    end

    test "Adicionar 2 folhas" do
        assert Tree.new |> Tree.addLeaf(1) |> Tree.addLeaf(2) == %Tree{leafs: [1,2]}
    end
end