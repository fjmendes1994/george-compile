defmodule GeorgeCompiler.SMC.Bool do
    @operations %{
        "eq" => &GeorgeCompiler.SMC.Bool.equals/1,
        "not" => &GeorgeCompiler.SMC.Bool.nt/1,
        "gt" => &GeorgeCompiler.SMC.Bool.greater_than/1,
        "lt" => &GeorgeCompiler.SMC.Bool.lesser_than/1,
        "get" => &GeorgeCompiler.SMC.Bool.greater_than/1,
        "let" => &GeorgeCompiler.SMC.Bool.lesser_than/1
    }

    def nt(s) do
        {x, s} = Stack.pop(s)
        Stack.push(s, not x)
    end

    def equals(s) do
        {x, y, s} = pop_twice(s)
        Stack.push(s, x==y)
    end

    def greater_than(s) do
        {y, x, s} = pop_twice(s)
        Stack.push(s, x > y)
    end

    def lesser_than(s) do
        {y, x, s} = pop_twice(s)
        Stack.push(s, x < y)
    end

    def greater_equals_than(s) do
        {y, x, s} = pop_twice(s)
        Stack.push(s, x >= y)
    end

    def lesser_equals_than(s) do
        {y, x, s} = pop_twice(s)
        Stack.push(s, x <= y)
    end

    def bool_and(s) do
        {y, x, s} = pop_twice(s)
        Stack.push(s, x and y)
    end

    def bool_or(s) do
        {y, x, s} = pop_twice(s)
        Stack.push(s, x or y)
    end

    def pop_twice(s) do
        {x, s} = Stack.pop(s)
        {y, s} = Stack.pop(s)
        {x, y, s}
    end

    def is_bool_exp(operation) do
        Enum.member? @operations, operation
    end

    def bool_decompose_tree(tree, c) do
        if tree.value == "not" do
            c |> Stack.push(Tree.new("not")) |> Stack.push(Enum.at(tree.leafs,0))
        else
            push_values(tree, c)
        end
    end

    def push_values(tree, c) do
        elem = Enum.at(tree.leafs, 0)
        if length(tree.leafs) > 1 do
            %{tree | leafs: tree.leafs |> Enum.drop(1)} |> push_values(c) |> Stack.push(elem)
        else
            c |> Stack.push(elem)
        end
    end
end