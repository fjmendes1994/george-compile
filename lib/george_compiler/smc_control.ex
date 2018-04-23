defmodule GeorgeCompiler.SMC.Control do
    @operations %{
        "atrib" => &GeorgeCompiler.SMC.Control.atrib/2
    }

    def control(exp, s, m) do
        operation = @operations[exp]
        {s, m} = operation.(s,m)
    end

    def atrib(s, m) do
        {value, var, s} = pop_twice(s)
        {s, Map.put(m, var, value)}
    end

    def control_decompose_tree(tree, c) do
        c = c
            |> Stack.push(Tree.new(tree.value))
        case tree.value do
            "atrib" -> atrib_decompose(tree, c)
        end
    end

    defp atrib_decompose(tree, c) do
        elem = Enum.at(tree.leafs,0)
        if length(tree.leafs) > 1 do
            %{tree | leafs: tree.leafs 
                            |> Enum.drop(1)} 
            |> atrib_decompose(c) 
            |> Stack.push(elem)
        else
            c 
            |> Stack.push(elem)
        end
    end

    def is_control(operation), do: Map.has_key? @operations, operation

    def pop_twice(s) do
        {a, s} = Stack.pop(s) 
        {b, s} = Stack.pop(s)
        {a, b, s}
    end
end