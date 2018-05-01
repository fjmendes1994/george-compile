defmodule SMCAttribTest do
    @moduledoc false

    import GeorgeCompiler.SMC.Attribution
    use ExUnit.Case

    test "Atribuição simples" do
        s = Stack.new
            |> Stack.push("var")
            |> Stack.push(5)
        m = %{"var" => 5}
        assert attrib(nil, s, %{}, Stack.new) == {Stack.new, m, Stack.new}
    end

    test "Recupera valor de variavel dado o mapa" do
        m = %{"var" => 5}
        assert get_variable_value("var", m) == 5
    end

    test "Decompoe arvore de atribuição" do
        tree = Tree.new("attrib")
                |> Tree.add_leaf("var")
                |> Tree.add_leaf(5)
    
        s = Stack.new
            |> Stack.push("var")

        c = Stack.new
            |> Stack.push(Tree.new("attrib"))
            |> Stack.push(Tree.new(5))
        assert attribution_decompose_tree(tree, Stack.new, %{}, Stack.new) == {s, %{}, c}
    end
end