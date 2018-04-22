defmodule GeorgeCompiler.SMC.Control do
    @operations %{
        "atrib" => &GeorgeCompiler.SMC.Control.atrib/1
    }

    def atrib(s, m) do
        {value, var, s} = pop_twice(s)
        {s, Map.put(m, var, value)}
    end

    def pop_twice(s) do
        {a, s} = Stack.pop(s) 
        {b, s} = Stack.pop(s)
        {a, b, s}
    end
end