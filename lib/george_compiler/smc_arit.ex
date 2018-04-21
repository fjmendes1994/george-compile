defmodule GeorgeCompiler.SMC.Arit do
    @operations %{  
        "add" => &GeorgeCompiler.SMC.Arit.add/1, 
        "sub" => &GeorgeCompiler.SMC.Arit.sub/1,
        "mult"=> &GeorgeCompiler.SMC.Arit.mult/1,
        "div"=> &GeorgeCompiler.SMC.Arit.div/1
    }

    def artit_exp(operation,s) do
        expression = @operations[operation]
        expression.(s)
    end

    def add(s)do
        {x,y,s} = pop_twice(s)
        Stack.push(s, x+y)
    end

    def mult(s)do
        {x,y,s} = pop_twice(s)
        Stack.push(s, y*x)
    end

    @doc "Subtração e divisão sendo feitas ao contrário para compensar ordem da pilha"
    def sub(s)do
        {x,y,s} = pop_twice(s)
        Stack.push(s, y-x)
    end

    def div(s)do
        {x,y,s} = pop_twice(s)
        Stack.push(s, y/x)
    end

    def is_arit_exp(operation) do
        IO.inspect Map.has_key? @operations, operation
    end
    
    defp pop_twice(s) do
        {x,s} = Stack.pop(s)
        {y,s} = Stack.pop(s)
        {x,y,s}
    end
end