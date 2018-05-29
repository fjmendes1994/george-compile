defmodule GeorgeCompiler.SMC.Command do

    alias GeorgeCompiler.SMC,as: SMC
    
    @operations %{
        :if => &GeorgeCompiler.SMC.Command.if_command/3,
        :while => &GeorgeCompiler.SMC.Command.while/3,
        :seq => nil
    }
    
    @doc """
    Função responsável por retornar as funções que efetuam operações na tupla SMC
    """
    def command(exp, smc) do
        operation = @operations[exp]
        operation.(smc)
    end

    @doc """
    C if E < t c c' S, M, if C > ⇒ < S, M, c'' C>
    """
    def if_command(smc) do
        {condition, if_block, smc} = SMC.pop_twice_value(smc)
        {else_block, smc} = SMC.pop_value(smc)
        if condition do
            smc
            |> SMC.add_control(if_block)
        else
            smc
            |> SMC.add_control(else_block)
        end
    end

    @doc """
    Aplicações de regra do while. Os comentários do código em que se aplicam as regras estão com as marcações #(número).\n
    #1 C while E1 < tt b c S, M, while C > ⇒ < S, M, c while b do c C > \n
    #2 C while E2 < ff b c S, M, while C > ⇒ < S, M, C >
    """
    def while(smc) do
        {condition, bool_exp, smc} = SMC.pop_twice_value(smc)
        {code, smc} = SMC.pop_value(smc)

        if condition do
            #constroi o while de novo
            #1
            tree = Tree.new(:while)
                    |> Tree.add_leaf(bool_exp)
                    |> Tree.add_leaf(code)
            #coloca o comando no topo da pilha c e o while em seguida
            smc
            |> SMC.add_control(tree)
            |> SMC.add_control(code)
        else
            #2
            smc
        end
    end

    def command_decompose_tree(tree, smc) do
        smc = smc
              |>  SMC.add_control(tree.value)
        case tree.value do
            :if -> if_decompose(tree, smc)
            :while -> while_decompose(tree, smc)
            :seq -> sequence_decompose(tree, smc)
        end
    end

    @doc """
    Decomposição da aŕvore de if. \n
    C if I < S, M, if b then c else c' C > ⇒ < c c' S, M, b if C >
    """
    def if_decompose(tree, smc) do
        smc
        |> SMC.add_value(Enum.at(tree.leafs, 2))
        |> SMC.add_value(Enum.at(tree.leafs, 1))
        |> SMC.add_control(Enum.at(tree.leafs, 0))
    end

     
    @doc """
    Decomposição da aŕvore de while. \n
    #1 C while I < S, M, while b do c C > ⇒ < b c S, M, b while C > \n
    """
    def while_decompose(tree, smc) do
        smc
        |> SMC.add_value(Enum.at(tree.leafs, 1))
        |> SMC.add_value(Enum.at(tree.leafs, 0))
        |> SMC.add_control(Enum.at(tree.leafs, 0))
    end

    @doc """
    C; < S, M, c; c' C > ⇒ < S, M, c c' C >
    """
    def sequence_decompose(tree, smc) do
        {_, smc} = SMC.pop_control(smc)
        
        smc
        |> SMC.add_control(Enum.at(tree.leafs, 1))
        |> SMC.add_control(Enum.at(tree.leafs, 0))
    end

    @doc "Verifica se a operação está mapeada no módulo"
    def is_command(operation), do: Map.has_key? @operations, operation

    defp get_value(value, m) do
        if is_binary(value) do
            m[value]
        else
            value
        end
    end
end