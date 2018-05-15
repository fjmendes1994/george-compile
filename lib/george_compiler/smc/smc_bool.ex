defmodule GeorgeCompiler.SMC.Bool do
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
    def bool_exp(exp, s, m, c) do
        operation = @operations[exp]
        {operation.(s), m, c}
    end

    @doc """
    B ∼ E \< t S, M, ∼ C \> ⇒ \< t' S, M, C \>
    """
    def nt(s) do
        {x, s} = Stack.pop(s)
        Stack.push(s, not x)
    end

    @doc """
    B = E \< m' m S, M, = C \> ⇒ \< t S, M, C \>
    """
    def equals(s) do
        {x, y, s} = StackUtils.pop_twice(s)
        Stack.push(s, x == y)
    end

    @doc false
    def greater_than(s) do
        {y, x, s} = StackUtils.pop_twice(s)
        Stack.push(s, x > y)
    end

    @doc false
    def lesser_than(s) do
        {y, x, s} = StackUtils.pop_twice(s)
        Stack.push(s, x < y)
    end

    @doc false
    def greater_equals_than(s) do
        {y, x, s} = StackUtils.pop_twice(s)
        Stack.push(s, x >= y)
    end

    @doc false
    def lesser_equals_than(s) do
        {y, x, s} = StackUtils.pop_twice(s)
        Stack.push(s, x <= y)
    end

    @doc false
    def bool_and(s) do
        {y, x, s} = StackUtils.pop_twice(s)
        Stack.push(s, x and y)
    end

    @doc """
    B or E \< t' t S, M, or C \> ⇒ \< t'' S, M, C \>
    """
    def bool_or(s) do
        {y, x, s} = StackUtils.pop_twice(s)
        Stack.push(s, x or y)
    end

    @doc "Verifica se a operação está mapeada no módulo"
    def is_bool_exp(operation), do: Map.has_key? @operations, operation

    @doc """
    Aplica todas as decomposições de árvore para operações booleanas. Sempre empilha a operação para depois chamar a função que empilha os valores\n
    B = I \< S, M, e = e' C \> ⇒ \< S, M, e e' = C \> \n
    B or I \< S, M, b or b' C \> ⇒ \< S, M, b b' or C \> \n
    B ∼ I \< S, M, ∼ b C \> ⇒ \< S, M, b ∼ C \>
    """
    def bool_decompose_tree(tree, s, m, c) do
        {s, m, tree 
                |> push_values(StackUtils.push_as_tree(c, tree.value))}
    end

    @doc false
    def push_values(tree, c) do
        elem = Enum.at(tree.leafs, 0)
        if length(tree.leafs) > 1 do
            tree
            |> TreeUtils.remove_first_leaf
            |> push_values(c) 
            |> Stack.push(elem)
        else
            c |> Stack.push(elem)
        end
    end
end