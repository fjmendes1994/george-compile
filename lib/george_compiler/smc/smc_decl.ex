defmodule GeorgeCompiler.SMC.Decl do
    @operations %{
        :decl => nil,
        :ref => &GeorgeCompiler.SMC.Decl.ref/1,
        :cns => &GeorgeCompiler.SMC.Decl.cns/1,
        :blk => &GeorgeCompiler.SMC.Decl.blk/1
    }
    alias GeorgeCompiler.SMC, as: SMC

    def decl(operation, smc) do
        function = @operations[operation]    
        function.(smc)
    end

    def ref(smc) do
        smc
        |> SMC.add_reference
    end

    def cns(smc) do
        smc
        |> SMC.add_const
    end

    def blk(smc) do
        {env, smc} = SMC.pop_value(smc)
        %{smc | e: env}
        |> SMC.clean_store
    end

    def is_declaration(operation) do 
        Map.has_key? @operations, operation
    end

    def decl_decompose_tree(tree, smc) do
        cond do
            tree.value == :decl -> dec_decompose_tree(tree, smc)
            tree.value == :blk -> blk_decompose_tree(tree, smc)
            :true -> env_decompose_tree(tree, smc)
        end
    end

    defp dec_decompose_tree(tree, smc) do
        smc
        |> push_values(tree)
    end

    defp blk_decompose_tree(tree, smc) do
        smc
        |> SMC.add_control(tree.value)
        |> SMC.add_value(smc.e)
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
        smc  
        |> SMC.add_control(tree.value)
        |> SMC.add_control(Tree.get_leaf(tree, 1))
        #Extrai o valor da árvore
        |> SMC.add_value(Tree.get_leaf(tree, 0).value)
    end
end