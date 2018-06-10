defmodule GeorgeCompiler.Compiler do
    alias GeorgeCompiler.SMC, as: SMC

    import GeorgeCompiler.SMC.Arit
    import GeorgeCompiler.SMC.Attribution
    import GeorgeCompiler.SMC.Bool
    import GeorgeCompiler.SMC.Command
    import GeorgeCompiler.SMC.Decl

    @doc """
    Operação que consome a pilha C para aplicação das regras
    """
    def evaluate(smc) do
        if Stack.depth(smc.c) > 0 do
            SMC.pop_control(smc)
            |> do_operation
            |> evaluate
        else
            smc
        end
    end

    @doc """
    Função usada para avaliar o elemento retirado do topo da pilha C.\n
    Avalia se é valor(incluindo nulo) ou uma árvore e chama a função que cuida da aplicação da regra correspondente.\n

    C nil \< S, M, nil C \> ⇒ \< S, M, C \>
    """
    def do_operation({node, smc}) do
        if Tree.is_leaf node do 
            unless TreeUtils.is_nil(node) do
                modify_s(node, smc)
            else
                smc
            end
        else
            decompose_tree(node, smc)
        end
    end

    defp decompose_tree(tree, smc) do
        cond do
            is_arit_exp(tree.value) -> arit_decompose_tree(tree, smc)
            is_attribution(tree.value) -> attribution_decompose_tree(tree, smc)
            is_bool_exp(tree.value) -> bool_decompose_tree(tree, smc)
            is_command(tree.value) -> command_decompose_tree(tree, smc) 
            is_declaration(tree.value) -> decl_decompose_tree(tree, smc)
        end
    end

    defp modify_s(node, smc) do
        if is_value node.value do
            push_value(node, smc)
        else
            get_operation(node.value)
            |> apply_operation(node.value, smc)
        end
    end

    defp is_value(value) do
        not (is_arit_exp(value) or is_bool_exp(value) or is_command(value) or is_attribution(value))
    end

    @doc """
    Aplica operação no topo da pilha\n
    Ev < S, M, v C > ⇒ < M (v) S, M, C > \n
    En \< S, M, t C \> ⇒ \< n S, M, C \>\n
    Bt \< S, M, t C \> ⇒ \< t S, M, C \>
    """

    def push_value(node, smc) do
        value = node.value
          cond do
              is_binary value -> SMC.add_value(smc, SMC.get_stored_value(smc, value))
              true -> SMC.add_value(smc, value)
          end
    end

    defp get_operation(operation) do
        cond do
            is_arit_exp(operation) -> &artit_exp/2
            is_attribution(operation) -> &attrib/2
            is_bool_exp(operation) -> &bool_exp/2
            is_command(operation) -> &command/2
        end
    end

    defp apply_operation(function, operation, smc) do
        function.(operation, smc)
    end
end