defmodule GeorgeCompiler.SMC.Arit do
    @operations %{  
        "add" => &GeorgeCompiler.SMC.Arit.add/2, 
        "sub" => &GeorgeCompiler.SMC.Arit.sub/2,
        "mul"=> &GeorgeCompiler.SMC.Arit.mul/2,
        "div"=> &GeorgeCompiler.SMC.Arit.div/2,
        "rem" => &GeorgeCompiler.SMC.Arit.rem_arit/2
    }

    def artit_exp(operation, s, m, c) do
        expression = @operations[operation]
        {expression.(s, m), m, c}
    end

    def add(s, m)do
        {x,y,s} = StackUtils.pop_twice(s)
        Stack.push(s, get_value(x, m) + get_value(y, m))
    end

    def mul(s, m)do
        {x,y,s} = StackUtils.pop_twice(s)
        Stack.push(s, get_value(x, m) * get_value(y, m))
    end

    @doc "Subtração e divisão sendo feitas ao contrário para compensar ordem da pilha"
    def sub(s, m)do
        {x,y,s} = StackUtils.pop_twice(s)
        Stack.push(s, get_value(y, m) - get_value(x, m))
    end

    def div(s, m)do
        {x,y,s} = StackUtils.pop_twice(s)
        Stack.push(s, get_value(y, m) / get_value(x, m))
    end

    def rem_arit(s, m)do
        {x,y,s} = StackUtils.pop_twice(s)
        Stack.push(s, rem(get_value(x, m), get_value(y, m)))
    end

    def is_arit_exp(operation), do: Map.has_key? @operations, operation

    @doc "Usado para inserir o tipo de operação no topo da pilha antes de empilhar os valores"
    def arit_decompose_tree(tree, s, m, c) do
       {s, m, tree 
                |> push_values(StackUtils.push_as_tree(c, tree.value))}
    end

    defp get_value(value, m) do
        if is_binary(value) do
            m[value]
        else
            value
        end
    end

    defp push_values(tree, c) do
        elem = Enum.at(tree.leafs,0)
        if length(tree.leafs) > 1 do
            tree
            |> TreeUtils.remove_first_leaf
            |> push_values(c) 
            |> Stack.push(elem)
        else
            c 
            |> Stack.push(elem)
        end
    end
end