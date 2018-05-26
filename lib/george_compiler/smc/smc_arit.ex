defmodule GeorgeCompiler.SMC.Arit do
    alias GeorgeCompiler.SMC,as: SMC
    @operations %{  
        :add => &GeorgeCompiler.SMC.Arit.add/1,
        :sub => &GeorgeCompiler.SMC.Arit.sub/1,
        :mul=> &GeorgeCompiler.SMC.Arit.mul/1,
        :div=> &GeorgeCompiler.SMC.Arit.div/1,
        :rem => &GeorgeCompiler.SMC.Arit.rem_arit/1
    }

    @doc """
    Função usada pelo módulo SMC para se efetuar a operação (operation). O valor é guardado no topo da pilha.
    
    E − E < m m' S, M, +/-/* C > ⇒ < n S, M, C >
    """
    def artit_exp(operation, smc, a, b) do
        expression = @operations[operation]
        smc 
        |> expression.(smc)
    end

    @doc false
    def add(smc) do
        {x, y, smc} = SMC.pop_twice_value(smc)
        SMC.add_value(smc, x+y)
    end

    @doc false
    def mul(smc)do
        {x, y, smc} = SMC.pop_twice_value(smc)
        SMC.add_value(smc, x*y)
    end

    @doc false
    #Subtração e divisão sendo feitas ao contrário para compensar ordem da pilha
    def sub(smc) do
        {x, y, smc} = SMC.pop_twice_value(smc)
        SMC.add_value(smc, y-x)
    end

    @doc false
    def div(smc) do
        {x, y, smc} = SMC.pop_twice_value(smc)
        SMC.add_value(smc, y/x)
    end

    @doc false
    def rem_arit(smc) do
        {x, y, smc} = SMC.pop_twice_value(smc)
        SMC.add_value(smc, y/x)
    end

    @doc "Verifica se a operação está mapeada no módulo"
    def is_arit_exp(operation), do: Map.has_key? @operations, operation

    @doc """
    Usado para decompor a árvore de operação. Esta função sempre empilha o tipo de operação antes de chamar a função que empilha os valores
        
    E − I < S, M, e + / - / * e' 0 C> ⇒ < S, M, e e' +/-/ * C>
    """
		def arit_decompose_tree(tree, smc) do
			SMC.add_control(tree.value)
			|> push_values(smc)
    end

    defp push_values(tree, smc) do
        elem = Enum.at(tree.leafs,0)
        if length(tree.leafs) > 1 do
            tree
            |> TreeUtils.remove_first_leaf
            |> push_values(smc) 
            |> SMC.add_control(elem)
        else
            smc 
            |> SMC.add_control(elem)
        end
    end
end