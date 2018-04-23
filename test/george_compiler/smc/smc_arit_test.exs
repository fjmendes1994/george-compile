defmodule SMCAritTest do
    @moduledoc false
    
    use ExUnit.Case
    
    test "Adição" do
        assert  create_s(2, 1) |> GeorgeCompiler.SMC.Arit.add(%{})  == Stack.new |> Stack.push(3)   
    end

    test "Subtração" do
        assert create_s(2, 1) |> GeorgeCompiler.SMC.Arit.sub(%{})  == Stack.new |> Stack.push(1)   
    end

    test "Multiplicação" do
        assert create_s(2, 1) |> GeorgeCompiler.SMC.Arit.mult(%{})  == Stack.new |> Stack.push(2)
    end

    test "Divisão" do
        assert create_s(2, 1) |> GeorgeCompiler.SMC.Arit.div(%{})  == Stack.new |> Stack.push(2)   
    end

    test "Adição usando x como variavel" do
        assert  create_s("x", 1) |> GeorgeCompiler.SMC.Arit.add(%{"x" => 2})  == Stack.new |> Stack.push(3)   
    end

    test "Subtração usando x como variavel" do
        assert create_s("x", 1) |> GeorgeCompiler.SMC.Arit.sub(%{"x" => 2})  == Stack.new |> Stack.push(1)   
    end

    test "Multiplicação usando x como variavel" do
        assert create_s("x", 1) |> GeorgeCompiler.SMC.Arit.mult(%{"x" => 2})  == Stack.new |> Stack.push(2)
    end

    test "Divisão usando x como variavel" do
        assert create_s("x", 1) |> GeorgeCompiler.SMC.Arit.div(%{"x" => 2})  == Stack.new |> Stack.push(2)   
    end

    test "Adição usando y como variavel" do
        assert  create_s(2, "y") |> GeorgeCompiler.SMC.Arit.add(%{"y" => 1})  == Stack.new |> Stack.push(3)   
    end

    test "Subtração usando y como variavel" do
        assert create_s(2, "y") |> GeorgeCompiler.SMC.Arit.sub(%{"y" => 1})  == Stack.new |> Stack.push(1)   
    end

    test "Multiplicação usando y como variavel" do
        assert create_s(2, "y") |> GeorgeCompiler.SMC.Arit.mult(%{"y" => 1})  == Stack.new |> Stack.push(2)
    end

    test "Divisão usando y como variavel" do
        assert create_s(2, "y") |> GeorgeCompiler.SMC.Arit.div(%{"y" => 1})  == Stack.new |> Stack.push(2)   
    end

    test "Adição usando x e y como variaveis" do
        assert create_s("x", "y") |> GeorgeCompiler.SMC.Arit.add(%{"x"=> 2, "y" => 1})  == Stack.new |> Stack.push(3)   
    end

    test "Subtração usando x e y como variaveis" do
        assert create_s("x", "y") |> GeorgeCompiler.SMC.Arit.sub(%{"x"=> 2, "y" => 1})  == Stack.new |> Stack.push(1)   
    end

    test "Multiplicação usando x e y como variaveis" do
        assert create_s("x", "y") |> GeorgeCompiler.SMC.Arit.mult(%{"x"=> 2, "y" => 1})  == Stack.new |> Stack.push(2)
    end

    test "Divisão usando x e y como variaveis" do
        assert create_s("x", "y") |> GeorgeCompiler.SMC.Arit.div(%{"x"=> 2, "y" => 1})  == Stack.new |> Stack.push(2)   
    end

    defp create_s(a, b), do: Stack.new 
                        |> Stack.push(a) 
                        |> Stack.push(b)

    test "Divisão da árvore" do
        tree = Tree.new("add") 
                |> Tree.add_leaf(5) 
                |> Tree.add_leaf(3)
        decomposed = Stack.new 
                    |> Stack.push(Tree.new("add")) 
                    |> Stack.push(Tree.new(3)) 
                    |> Stack.push(Tree.new(5))
        assert GeorgeCompiler.SMC.Arit.arit_decompose_tree(tree, Stack.new, %{} , Stack.new) == {Stack.new , %{}, decomposed}
    end
end