defmodule GeorgeCompiler.SMC.Control do
    @operations %{
        "atrib" => &GeorgeCompiler.SMC.Control.atrib/3
    }

    def control(exp, s, m, c) do
        operation = @operations[exp]
        operation.(s, m, c)
    end

    def atrib(s, m, c) do
        {value, var, s} = StackUtils.pop_twice(s)
        {s, Map.put(m, var, value), c}
    end

    def control_decompose_tree(tree, s, m, c) do
        c = c
            |> StackUtils.push_as_tree(tree.value)
        case tree.value do
            "atrib" -> atrib_decompose(tree, s, m, c)
            "if" -> if_decompose(tree, s, m, c)
        end
    end

    defp atrib_decompose(tree, s, m, c) do
        elem = Enum.at(tree.leafs,0)
        if length(tree.leafs) > 1 do
            {s, m, tree
                    |> TreeUtils.remove_first_leaf
                    |> atrib_decompose(s, m, c) 
                    |> Stack.push(elem)}
        else
            c 
            |> Stack.push(elem)
        end
    end

    defp if_decompose(tree, s, m, c) do
        
    end

    def is_control(operation), do: Map.has_key? @operations, operation
end