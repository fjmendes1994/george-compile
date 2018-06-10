defmodule SMCDeclTest do
    @moduledoc false
    alias GeorgeCompiler.SMC.Decl, as: Decl
    alias GeorgeCompiler.SMC, as: SMC
    
    use ExUnit.Case
    
    test "Decomposiçáo da árvore" do
        smc = SMC.new
              |> SMC.add_control(Tree.new(:ref)
                                 |> Tree.add_leaf("init")
                                 |> Tree.add_leaf("2"))      
              |> SMC.add_control(Tree.new(:ref)
                                |> Tree.add_leaf("var")
                                |> Tree.add_leaf("5"))
              
        tree = Tree.new(:decl)
                        |> Tree.add_leaf(Tree.new(:ref)
                                        |> Tree.add_leaf("var")
                                        |> Tree.add_leaf("5"))
                        |> Tree.add_leaf(Tree.new(:ref)
                                        |> Tree.add_leaf("init")
                                        |> Tree.add_leaf("2"))        
        assert Decl.decl_decompose_tree(tree, SMC.new) == smc
    end

    test "Decomposiçáo da árvore ref e init" do
        smc = SMC.new
              |> SMC.add_control(:ref)
              |> SMC.add_control(5)
              |> SMC.add_value("var")
              
        tree = Tree.new(:ref)
                |> Tree.add_leaf("var")
                |> Tree.add_leaf(5)   
        assert Decl.decl_decompose_tree(tree, SMC.new) == smc
    end

    test "Aplicação de ref" do
        smc = SMC.new
              |> SMC.add_value("var")
              |> SMC.add_value(5)

        ref = Decl.ref(smc)

        assert %SMC{e: %Environment{refs: [var: x]}} = ref
        assert %SMC{m: %{^x => 5}} = ref
    end

    test "Aplicação de const" do
        smc = SMC.new
              |> SMC.add_value("var")
              |> SMC.add_value(5)

        ref = Decl.const(smc)

        assert %SMC{e: %Environment{refs: [var: 5]}} == ref
    end

    test "Aplicação do fechamento do bloco" do
        smc = SMC.new
              |> SMC.add_store("var", 5)
              |> SMC.add_value(%Environment{})

        assert Decl.blk(smc) == SMC.new
    end
end