defmodule GeorgeCompiler.SMC.Command do
    @operations %{
        "if" => &GeorgeCompiler.SMC.Command.if_command/3,
        "while" => &GeorgeCompiler.SMC.Command.while/3,
        "seq" => nil
    }
    
    @doc """
    Função responsável por retornar as funções que efetuam operações na tupla SMC
    """
    def command(exp, s, m, c) do
        operation = @operations[exp]
        operation.(s, m, c)
    end

    @doc """
    C if E < t c c' S, M, if C > ⇒ < S, M, c'' C>
    """
    def if_command(s, m, c) do
        {condition, s} = Stack.pop(s)
        {if_block, s} = Stack.pop(s)
        {else_block, s} = Stack.pop(s)
        if condition do
            {s, m, Stack.push(c, if_block)}
        else
            {s, m, Stack.push(c, else_block)}
        end
    end

    @doc """
    Aplicações de regra do while. Os comentários do código em que se aplicam as regras estão com as marcações #(número).\n
    #1 C while E1 < tt b c S, M, while C > ⇒ < S, M, c while b do c C > \n
    #2 C while E2 < ff b c S, M, while C > ⇒ < S, M, C >
    """
    def while(s, m, c) do
        {condition, s} = Stack.pop(s)
        {bool_exp, s} = Stack.pop(s)
        {code, s} = Stack.pop(s)

        if condition do
            #constroi o while de novo
            #1
            tree = Tree.new("while")
                    |> Tree.add_leaf(bool_exp)
                    |> Tree.add_leaf(code)
            #coloca o comando no topo da pilha c e o while em seguida
            {s, m, c
                    |> Stack.push(tree)
                    |> Stack.push(code)}
        else
            #2
            {s, m, c}
        end
    end

    def command_decompose_tree(tree, s, m, c) do
        c = c
            |> StackUtils.push_as_tree(tree.value)
        case tree.value do
            "if" -> if_decompose(tree, s, m, c)
            "while" -> while_decompose(tree, s, m, c)
            "seq" -> sequence_decompose(tree, s, m, c)
        end
    end

    @doc """
    Decomposição da aŕvore de if. \n
    C if I < S, M, if b then c else c' C > ⇒ < c c' S, M, b if C >
    """
    def if_decompose(tree, s, m, c) do
        s = s
            |> Stack.push(Enum.at(tree.leafs, 2))
            |> Stack.push(Enum.at(tree.leafs, 1))
        c = c
            |> Stack.push(Enum.at(tree.leafs, 0))
        {s, m, c}
    end

     
    @doc """
    Decomposição da aŕvore de while. \n
    #1 C while I < S, M, while b do c C > ⇒ < b c S, M, b while C > \n
    """
    def while_decompose(tree, s, m, c) do
        s = s
            |> Stack.push(Enum.at(tree.leafs, 1))
            |> Stack.push(Enum.at(tree.leafs, 0))
        c = c
            |> Stack.push(Enum.at(tree.leafs, 0))
        {s, m, c}
    end

    @doc """
    C; < S, M, c; c' C > ⇒ < S, M, c c' C >
    """
    def sequence_decompose(tree, s, m, c) do
        {_, c} = Stack.pop(c)
        {s, m, c
                |> Stack.push(Enum.at(tree.leafs, 1))
                |> Stack.push(Enum.at(tree.leafs, 0))}
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