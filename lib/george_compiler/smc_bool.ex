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

    def pop_twice(s) do
        {x, s} = Stack.pop(s)
        {y, s} = Stack.pop(s)
        {x, y, s}
    end
end