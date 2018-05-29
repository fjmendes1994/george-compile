defmodule GeorgeCompiler.SMC.Bool do

    alias GeorgeCompiler.SMC,as: SMC

    @operations %{
        :eq => &GeorgeCompiler.SMC.Bool.equals/1,
        :neg => &GeorgeCompiler.SMC.Bool.nt/1,
        :gt => &GeorgeCompiler.SMC.Bool.greater_than/1,
        :lt => &GeorgeCompiler.SMC.Bool.lesser_than/1,
        :ge => &GeorgeCompiler.SMC.Bool.greater_than/1,
        :le => &GeorgeCompiler.SMC.Bool.lesser_than/1,
        :or => &GeorgeCompiler.SMC.Bool.bool_or/1,
        :and => &GeorgeCompiler.SMC.Bool.bool_or/1
    }

    @doc """
    Função que chama a aplicação das regras booleanas.\n
    """
    def bool_exp(exp, smc) do
        operation = @operations[exp]
        operation.(smc)
    end

    @doc """
    B ∼ E \< t S, M, ∼ C \> ⇒ \< t' S, M, C \>
    """
    def nt(smc) do
        {x, smc} = SMC.pop_value(smc)
        SMC.add_value(smc, not x)
    end

    @doc """
    B = E \< m' m S, M, = C \> ⇒ \< t S, M, C \>
    """
    def equals(smc) do
        {x, y, smc} = SMC.pop_twice_value(smc)
        SMC.add_value(smc, x==y)
    end

    @doc false  
    def greater_than(smc) do
        {y, x, smc} = SMC.pop_twice_value(smc)
        SMC.add_value(smc, x>y)
    end

    @doc false
    def lesser_than(smc) do
        {x, y, smc} = SMC.pop_twice_value(smc)
        SMC.add_value(smc, x<y)
    end

    @doc false
    def greater_equals_than(smc) do
        {y, x, smc} = SMC.pop_twice_value(smc)
        SMC.add_value(smc, x>=y)
    end

    @doc false
    def lesser_equals_than(smc) do
        {x, y, smc} = SMC.pop_twice_value(smc)
        SMC.add_value(smc, x<=y)
    end

    @doc false
    def bool_and(smc) do
        {x, y, smc} = SMC.pop_twice_value(smc)
        SMC.add_value(smc, x and y)
    end

    @doc """
    B or E \< t' t S, M, or C \> ⇒ \< t'' S, M, C \>
    """
    def bool_or(smc) do
        {x, y, smc} = SMC.pop_twice_value(smc)
        SMC.add_value(smc, x or y)
    end

    @doc "Verifica se a operação está mapeada no módulo"
    def is_bool_exp(operation), do: Map.has_key? @operations, operation

    @doc """
    Aplica todas as decomposições de árvore para operações booleanas. Sempre empilha a operação para depois chamar a função que empilha os valores\n
    B = I \< S, M, e = e' C \> ⇒ \< S, M, e e' = C \> \n
    B or I \< S, M, b or b' C \> ⇒ \< S, M, b b' or C \> \n
    B ∼ I \< S, M, ∼ b C \> ⇒ \< S, M, b ∼ C \>
    """
    def bool_decompose_tree(tree, smc) do
        smc
        |> SMC.add_control(tree.value)
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
end