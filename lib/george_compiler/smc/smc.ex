defmodule GeorgeCompiler.SMC do
    import GeorgeCompiler.SMC.Arit
    import GeorgeCompiler.SMC.Attribution
    import GeorgeCompiler.SMC.Bool
    import GeorgeCompiler.SMC.Command

    @doc """
    Operação que consome a pilha C para aplicação das regras
    """
    def evaluate(s, m, c) do
        if Stack.depth(c) > 0 do
            {node, c} = Stack.pop(c)
            {s, m, c} = do_operation(node, s, m, c)
            evaluate(s, m, c)
        else
            {s, m, c}
        end
    end

    @doc """
    Função usada para avaliar o elemento retirado do topo da pilha C.\n
    Avalia se é valor(incluindo nulo) ou uma árvore e chama a função que cuida da aplicação da regra correspondente.\n

    C nil \< S, M, nil C \> ⇒ \< S, M, C \>
    """
    def do_operation(node, s, m, c) do
        if Tree.is_leaf node do 
            unless TreeUtils.is_nil(node) do
                modify_s(node, s, m, c)
            else
                {s, m, c}
            end
        else
            decompose_tree(node, s, m, c)
        end
    end

    defp decompose_tree(tree, s, m, c) do
        cond do
            is_arit_exp(tree.value) -> arit_decompose_tree(tree, s, m, c)
            is_attribution(tree.value) -> attribution_decompose_tree(tree, s, m, c)
            is_bool_exp(tree.value) -> bool_decompose_tree(tree, s, m, c)
            is_control(tree.value) -> control_decompose_tree(tree, s, m, c) 
        end
    end

    defp modify_s(node, s, m, c) do
        if is_value node.value do
            push_value(node, s, m, c)
        else
            get_operation(node.value)
            |> apply_operation(node.value, s, m, c)
        end
    end

    defp is_value(value) do
        not (is_arit_exp(value) or is_bool_exp(value) or is_control(value) or is_attribution(value))
    end

    @doc """
    Aplica operação no topo da pilha\n
    Ev < S, M, v C > ⇒ < M (v) S, M, C > \n
    En \< S, M, t C \> ⇒ \< n S, M, C \>\n
    Bt \< S, M, t C \> ⇒ \< t S, M, C \>
    """

    def push_value(node, s, m, c) do
        value = node.value
        s = 
          cond do
              is_binary value -> Stack.push(s, get_variable_value(node.value,m))
              true -> Stack.push(s, node.value)
          end
        {s, m, c}
    end

    defp get_operation(operation) do
        cond do
            is_arit_exp(operation) -> &artit_exp/4
            is_attribution(operation) -> &attrib/4
            is_bool_exp(operation) -> &bool_exp/4
            is_control(operation) -> &control/4
        end
    end

    defp apply_operation(function, operation, s, m, c) do
        function.(operation, s, m, c)
    end
end