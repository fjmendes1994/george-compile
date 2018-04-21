defmodule GeorgeCompiler.SMC do
    def evaluate(s, m, c) do
        if Stack.depth(c) > 0 do
            {node, c} = Stack.pop(c)
            {s, m, c} = do_operation(node, s, m, c)
            evaluate(s, m, c)
        else
            {s, m, c}
        end
    end

    def do_operation(node, s, m, c) do
        IO.inspect s
        cond do
            Tree.is_leaf node -> 
                if GeorgeCompiler.SMC.Arit.is_arit_exp(node.value) do
                    s = node.value |> GeorgeCompiler.SMC.Arit.artit_exp(s)
                    {s, m, c}
                else
                    {Stack.push(s,node.value), m, c} 
                end
        end
    end
end
