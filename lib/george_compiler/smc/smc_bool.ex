defmodule GeorgeCompiler.SMC.Bool do
    @operations %{
        "eq" => &GeorgeCompiler.SMC.Bool.equals/2,
        "not" => &GeorgeCompiler.SMC.Bool.nt/2,
        "gt" => &GeorgeCompiler.SMC.Bool.greater_than/2,
        "lt" => &GeorgeCompiler.SMC.Bool.lesser_than/2,
        "ge" => &GeorgeCompiler.SMC.Bool.greater_than/2,
        "le" => &GeorgeCompiler.SMC.Bool.lesser_than/2
    }

    def bool_exp(exp, s, m, c) do
        operation = @operations[exp]
        {operation.(s, m), m, c}
    end

    def nt(s, m) do
        {x, s} = Stack.pop(s)
        Stack.push(s, not get_value(x, m))
    end

    def equals(s, m) do
        {x, y, s} = StackUtils.pop_twice(s)
        Stack.push(s, get_value(x, m) == get_value(y, m))
    end

    def greater_than(s, m) do
        {y, x, s} = StackUtils.pop_twice(s)
        Stack.push(s, get_value(x, m) > get_value(y, m))
    end

    def lesser_than(s, m) do
        {y, x, s} = StackUtils.pop_twice(s)
        Stack.push(s, get_value(x, m) < get_value(y, m))
    end

    def greater_equals_than(s, m) do
        {y, x, s} = StackUtils.pop_twice(s)
        Stack.push(s, get_value(x, m) >= get_value(y, m))
    end

    def lesser_equals_than(s, m) do
        {y, x, s} = StackUtils.pop_twice(s)
        Stack.push(s, get_value(x, m) <= get_value(y, m))
    end

    def bool_and(s, m) do
        {y, x, s} = StackUtils.pop_twice(s)
        Stack.push(s, get_value(x, m) and get_value(y, m))
    end

    def bool_or(s, m) do
        {y, x, s} = StackUtils.pop_twice(s)
        Stack.push(s, get_value(x, m) or get_value(y, m))
    end

    defp get_value(value, m) do
        if is_binary(value) do
            m[value]
        else
            value
        end
    end

    def is_bool_exp(operation), do: Map.has_key? @operations, operation

    def bool_decompose_tree(tree, s, m, c) do
        {s, m, tree 
                |> push_values(StackUtils.push_as_tree(c, tree.value))}
    end

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