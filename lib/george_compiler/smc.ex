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
        cond do
            Tree.is_leaf value -> 
                if GeorgeCompiler.SMC.Arit.is_arit_exp(value) do
                    s = value.value |> GeorgeCompiler.SMC.Arit.artit_exp(s)
                    {s, m, c}
                else
                    {Stack.push(s,value.value), m, c} 
                end
        end
    end
end
