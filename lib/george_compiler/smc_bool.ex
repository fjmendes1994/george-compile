defmodule GeorgeCompiler.SMC.Bool do
    @operations %{
        "eq" => &GeorgeCompiler.SMC.Bool.equals/1,
        "not" => &GeorgeCompiler.SMC.Bool.nt/1
    }

    def equals(s) do
        {x, y, s} = pop_twice(s)
        Stack.push(s, x==y)
    end

    def nt(s) do
        {x, s} = Stack.pop(s)
        Stack.push(s, not x)
    end

    def pop_twice(s) do
        {x, s} = Stack.pop(s)
        {y, s} = Stack.pop(s)
        {x, y, s}
    end
end