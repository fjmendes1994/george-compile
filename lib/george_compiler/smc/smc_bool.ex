defmodule GeorgeCompiler.SMC.Bool do
    import GeorgeCompiler.SMC.Attribution, only: [get_variable_value: 2]
    @operations %{
        "eq" => &GeorgeCompiler.SMC.Bool.equals/2,
        "neg" => &GeorgeCompiler.SMC.Bool.nt/2,
        "gt" => &GeorgeCompiler.SMC.Bool.greater_than/2,
        "lt" => &GeorgeCompiler.SMC.Bool.lesser_than/2,
        "ge" => &GeorgeCompiler.SMC.Bool.greater_than/2,
        "le" => &GeorgeCompiler.SMC.Bool.lesser_than/2,
        "or" => &GeorgeCompiler.SMC.Bool.bool_or/2,
        "and" => &GeorgeCompiler.SMC.Bool.bool_or/2
    }

    @doc """
    Função que chama a aplicação das regras booleanas.\n
    """
    def bool_exp(exp, s, m, c) do
        operation = @operations[exp]
        {operation.(s, m), m, c}
    end

    @doc """
    B ∼ E \< t S, M, ∼ C \> ⇒ \< t' S, M, C \>
    """
    def nt(s, m) do
        {x, s} = Stack.pop(s)
        Stack.push(s, not get_value(x, m))
    end

    @doc """
    B = E \< m' m S, M, = C \> ⇒ \< t S, M, C \>
    """
    def equals(s, m) do
        {x, y, s} = StackUtils.pop_twice(s)
        Stack.push(s, get_value(x, m) == get_value(y, m))
    end

    @doc false
    def greater_than(s, m) do
        {y, x, s} = StackUtils.pop_twice(s)
        Stack.push(s, get_value(x, m) > get_value(y, m))
    end

    @doc false
    def lesser_than(s, m) do
        {y, x, s} = StackUtils.pop_twice(s)
        Stack.push(s, get_value(x, m) < get_value(y, m))
    end

    @doc false
    def greater_equals_than(s, m) do
        {y, x, s} = StackUtils.pop_twice(s)
        Stack.push(s, get_value(x, m) >= get_value(y, m))
    end

    @doc false
    def lesser_equals_than(s, m) do
        {y, x, s} = StackUtils.pop_twice(s)
        Stack.push(s, get_value(x, m) <= get_value(y, m))
    end

    @doc false
    def bool_and(s, m) do
        {y, x, s} = StackUtils.pop_twice(s)
        Stack.push(s, get_value(x, m) and get_value(y, m))
    end

    @doc """
    B or E \< t' t S, M, or C \> ⇒ \< t'' S, M, C \>
    """
    def bool_or(s, m) do
        {y, x, s} = StackUtils.pop_twice(s)
        Stack.push(s, get_value(x, m) or get_value(y, m))
    end

    @doc false
    defp get_value(value, m) do
        if is_binary(value) do
            get_variable_value(value, m)
        else
            value
        end
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