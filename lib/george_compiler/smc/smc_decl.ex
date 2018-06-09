defmodule GeorgeCompiler.SMC.Decl do
    @operations %{
        # :dec => GeorgeCompiler.SMC.Decl.dec/2
    }
    alias GeorgeCompiler.SMC, as: SMC

    def decl(operation, smc) do
        smc    
    end


    def decl_decompose_tree(tree, smc) do
        cond do
            tree.value == :decl -> dec_decompose_tree(tree, smc)
            :true -> env_decompose_tree(tree, smc)
        end
    end


    defp dec_decompose_tree(tree, smc) do
        smc
        |> push_values(tree)
    end

    defp push_values(smc, tree) do
        elem = Enum.at(tree.leafs,0)
        if length(tree.leafs) > 1 do
            smc
            |> push_values(TreeUtils.remove_first_leaf(tree)) 
            |> SMC.add_control(elem)
        else
            smc 
            |> SMC.add_control(elem)
        end
    end

    defp env_decompose_tree(tree, smc) do
        smc = smc  
              |> SMC.add_control(tree.value)
              |> SMC.add_control(Tree.get_leaf(tree, 1))
              #Extrai o valor da árvore
              |> SMC.add_value(Tree.get_leaf(tree, 0).value)
    end
end