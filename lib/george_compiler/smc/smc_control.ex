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

    def control_decompose_tree(tree, c) do
        c = c
            |> StackUtils.push_as_tree(tree.value)
        case tree.value do
            "atrib" -> atrib_decompose(tree, c)
        end
    end

    defp atrib_decompose(tree, c) do
        elem = Enum.at(tree.leafs,0)
        if length(tree.leafs) > 1 do
            tree
            |> TreeUtils.remove_first_leaf
            |> atrib_decompose(c) 
            |> Stack.push(elem)
        else
            c 
            |> Stack.push(elem)
        end
    end

    def is_control(operation), do: Map.has_key? @operations, operation
end