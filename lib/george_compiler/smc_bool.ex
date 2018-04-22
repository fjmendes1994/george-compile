defmodule GeorgeCompiler.SMC.Bool do
    @operations %{
        "eq" => &GeorgeCompiler.SMC.Bool.equals/1,
		"neq" => &GeorgeCompiler.SMC.Bool.not_equals/1,
        "not" => &GeorgeCompiler.SMC.Bool.nt/1,
        "gt" => &GeorgeCompiler.SMC.Bool.greater_than/1,
        "lt" => &GeorgeCompiler.SMC.Bool.lesser_than/1,
        "ge" => &GeorgeCompiler.SMC.Bool.greater_equals_than/1,
        "le" => &GeorgeCompiler.SMC.Bool.lesser_equals_than/1,
		"neg" => &GeorgeCompiler.SMC.Bool.nt/1
    }

    def bool_exp(exp, s) do
        operation = @operations[exp]
        operation.(s)
    end

    def nt(s) do
        {x, s} = Stack.pop(s)
        Stack.push(s, not x)
    end

    def equals(s) do
        {x, y, s} = pop_twice(s)
        Stack.push(s, x==y)
    end
	
	def not_equals(s) do
		{x, y, s} = pop_twice(s)
		Stack.push(s, x != y)
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
        Map.has_key? @operations, operation
    end

    def bool_decompose_tree(tree, c) do
        tree |> push_values(Stack.push(c, Tree.new(tree.value)))
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
