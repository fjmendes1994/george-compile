defmodule GeorgeCompiler.SMC.Bool do
    @operations %{
        "eq" => &GeorgeCompiler.SMC.Bool.equals/1,
        "not" => &GeorgeCompiler.SMC.Bool.nt/1,
        "gt" => &GeorgeCompiler.SMC.Bool.greater_than/1,
        "lt" => &GeorgeCompiler.SMC.Bool.lesser_than/1,
        "get" => &GeorgeCompiler.SMC.Bool.greater_than/1,
        "let" => &GeorgeCompiler.SMC.Bool.lesser_than/1
    }

    def bool_exp(exp, s, m, c) do
        operation = @operations[exp]
        {operation.(s), m, c}
    end

    def nt(s) do
        {x, s} = Stack.pop(s)
        Stack.push(s, not x)
    end

    def equals(s) do
        {x, y, s} = StackUtils.pop_twice(s)
        Stack.push(s, x==y)
    end

    def greater_than(s) do
        {y, x, s} = StackUtils.pop_twice(s)
        Stack.push(s, x > y)
    end

    def lesser_than(s) do
        {y, x, s} = StackUtils.pop_twice(s)
        Stack.push(s, x < y)
    end

    def greater_equals_than(s) do
        {y, x, s} = StackUtils.pop_twice(s)
        Stack.push(s, x >= y)
    end

    def lesser_equals_than(s) do
        {y, x, s} = StackUtils.pop_twice(s)
        Stack.push(s, x <= y)
    end

    def bool_and(s) do
        {y, x, s} = StackUtils.pop_twice(s)
        Stack.push(s, x and y)
    end

    def bool_or(s) do
        {y, x, s} = StackUtils.pop_twice(s)
        Stack.push(s, x or y)
    end

    def is_bool_exp(operation) do
        Map.has_key? @operations, operation
    end

    def bool_decompose_tree(tree, c) do
        tree 
        |> push_values(StackUtils.push_as_tree(c, tree.value))
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