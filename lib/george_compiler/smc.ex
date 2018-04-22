defmodule GeorgeCompiler.SMC do
    import GeorgeCompiler.SMC.Arit
    import GeorgeCompiler.SMC.Bool
    import GeorgeCompiler.SMC.Control

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
        if Tree.is_leaf node do 
            modify_s(node, s, m, c)
        else
            if is_arit_exp(node.value) do
                c = arit_decompose_tree(node, c)
                {s, m, c}
            else
                if is_bool_exp(node.value) do
                    c = bool_decompose_tree(node ,c)
                    {s, m , c}
                else 
                    if is_control(node.value) do
                        c = control_decompose_tree(node, c)
                        {s, m , c}
                    end
                end
            end
        end
    end

    defp modify_s(node, s, m, c) do
        if is_arit_exp(node.value) do
            s = node.value 
                |> artit_exp(s)
            {s, m, c}
        else
            if is_bool_exp(node.value) do
                s = node.value 
                    |> bool_exp(s)
                {s, m, c}
            else
                if is_control(node.value) do
                    {s, m} = node.value 
                            |> control(s, m)
                    {s, m, c}
                else
                    {Stack.push(s,node.value), m, c} 
                end
            end
        end
    end
end
