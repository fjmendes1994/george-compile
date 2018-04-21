defmodule GeorgeCompiler.SMC do
    
    def evaluate(s,m,c) do
        if Stack.depth(c) > 0 do
            {_,c} = Stack.pop(c)
            evaluate(s,m,c)
        else
            {s,m,c}
        end
    end
end
