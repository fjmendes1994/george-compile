defmodule GeorgeCompiler.SMC.Control do
    @operations %{
        "atrib" => &GeorgeCompiler.SMC.Control.atrib/3,
        "if" => &GeorgeCompiler.SMC.Control.if_control/3,
        "while" => &GeorgeCompiler.SMC.Control.while/3,
        "seq" => nil
    }

    def control(exp, s, m, c) do
        operation = @operations[exp]
        operation.(s, m, c)
    end

    def atrib(s, m, c) do
        {value, var, s} = StackUtils.pop_twice(s)
        {s, Map.put(m, var, value), c}
    end

    def if_control(s, m, c) do
        {condition, s} = Stack.pop(s)
        {if_block, s} = Stack.pop(s)
        {else_block, s} = Stack.pop(s)
        if condition do
            {s, m, Stack.push(c, if_block)}
        else
            {s, m, Stack.push(c, else_block)}
        end
    end

    def while(s, m, c) do
        {condition, s} = Stack.pop(s)
        {bool_exp, s} = Stack.pop(s)
        {code, s} = Stack.pop(s)

        if condition do
            #constroi o while de novo
            tree = Tree.new("while")
                    |> Tree.add_leaf(bool_exp)
                    |> Tree.add_leaf(code)
            #coloca o comando no topo da pilha c e o while em seguida
            {s, m, c
                    |> Stack.push(tree)
                    |> Stack.push(code)}
        else
            {s, m, c}
        end
    end

    def control_decompose_tree(tree, s, m, c) do
        c = c
            |> StackUtils.push_as_tree(tree.value)
        case tree.value do
            "atrib" -> atrib_decompose(tree, s, m, c)
            "if" -> if_decompose(tree, s, m, c)
            "while" -> while_decompose(tree, s, m, c)
            "seq" -> sequence_decompose(tree, s, m, c)
        end
    end

    defp atrib_decompose(tree, s, m, c) do
        elem = Enum.at(tree.leafs,0)
        if length(tree.leafs) > 1 do
            {s, m, tree
                    |> TreeUtils.remove_first_leaf
                    |> atrib_decompose(s, m, c) 
                    |> Stack.push(elem)}
        else
            c 
            |> Stack.push(elem)
        end
    end

    defp if_decompose(tree, s, m, c) do
        s = s
            |> Stack.push(Enum.at(tree.leafs, 2))
            |> Stack.push(Enum.at(tree.leafs, 1))
        c = c
            |> Stack.push(Enum.at(tree.leafs, 0))
        {s, m, c}
    end

    defp while_decompose(tree, s, m, c) do
        s = s
            |> Stack.push(Enum.at(tree.leafs, 1))
            |> Stack.push(Enum.at(tree.leafs, 0))
        c = c
            |> Stack.push(Enum.at(tree.leafs, 0))
        {s, m, c}
    end

    defp sequence_decompose(tree, s, m, c) do
        {_, c} = Stack.pop(c)
        {s, m, c
                |> Stack.push(Enum.at(tree.leafs, 1))
                |> Stack.push(Enum.at(tree.leafs, 0))}
    end

    def is_control(operation), do: Map.has_key? @operations, operation
end