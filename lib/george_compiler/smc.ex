defmodule GeorgeCompiler.SMC do
    
    def evaluate(s, m, c) do
        if Stack.depth(c) > 0 do
            {value, c} = Stack.pop(c)
            {s, m, c} = do_operation(value, s, m, c)
            evaluate(s, m, c)
        else
            {s, m, c}
        end
    end

    def do_operation(value, s, m, c) do
        {s, m, c}
    end
end
