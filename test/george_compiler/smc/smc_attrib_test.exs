defmodule SMCAttribTest do
    @moduledoc false

    alias GeorgeCompiler.SMC, as: SMC
    import GeorgeCompiler.SMC.Attribution
    use ExUnit.Case

    test "Atribuição simples" do
			smc = SMC.new
						|> SMC.add_value("var")
						|> SMC.add_value(5)
        assert attrib(nil, smc) == SMC.new 
                                   |> SMC.add_store("var", 5)
    end

    test "Recupera valor de variavel dado o mapa" do
        m = %{"var" => 5}
        assert get_variable_value("var", m) == 5
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