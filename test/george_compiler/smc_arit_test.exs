defmodule SMCAritTest do
    @moduledoc false
    
    use ExUnit.Case
    
    test "Adição" do
        assert  create_s() |> GeorgeCompiler.SMC.Arit.add  == Stack.new |> Stack.push(3)   
    end

    test "Subtração" do
        assert create_s() |> GeorgeCompiler.SMC.Arit.sub  == Stack.new |> Stack.push(1)   
    end

    test "Multiplicação" do
        assert create_s() |> GeorgeCompiler.SMC.Arit.mult  == Stack.new |> Stack.push(2)
    end

    test "Divisão" do
        assert create_s() |> GeorgeCompiler.SMC.Arit.div  == Stack.new |> Stack.push(2)   
    end

    def create_s(), do: Stack.new |> Stack.push(2) |> Stack.push(1)

    test "Divisão da árvore" do
        tree = Tree.new("add") |> Tree.add_leaf(5) |> Tree.add_leaf(3)
        decomposed = Stack.new |> Stack.push(Tree.new("add")) |> Stack.push(Tree.new(3)) |> Stack.push(Tree.new(5))
        assert GeorgeCompiler.SMC.Arit.arit_decompose_tree(tree, Stack.new) == decomposed
    end
end