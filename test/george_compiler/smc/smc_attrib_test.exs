defmodule SMCAttribTest do
    @moduledoc false

    alias GeorgeCompiler.SMC, as: SMC
    import GeorgeCompiler.SMC.Attribution
    use ExUnit.Case

    test "Recupera valor de variavel dado o mapa" do
        smc = SMC.new
              |> SMC.add_value("var")
              |> SMC.add_value(5)
              |> SMC.add_const
        assert get_variable_value("var", smc) == 5

        smc = SMC.new
              |> SMC.add_value("var")
              |> SMC.add_value(5)
              |> SMC.add_reference
              assert get_variable_value("var", smc) == 5
    end

    test "Decompoe arvore de atribuição" do
        tree = Tree.new("attrib")
                |> Tree.add_leaf("var")
                |> Tree.add_leaf(5)

        smc = SMC.new
              |> SMC.add_value("var")
              |> SMC.add_control("attrib")
              |> SMC.add_control(5)
    
        assert attribution_decompose_tree(tree, SMC.new) == smc
    end
end