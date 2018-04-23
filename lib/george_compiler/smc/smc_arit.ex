defmodule GeorgeCompiler.SMC.Arit do
    @operations %{  
        "add" => &GeorgeCompiler.SMC.Arit.add/1, 
        "sub" => &GeorgeCompiler.SMC.Arit.sub/1,
        "mult"=> &GeorgeCompiler.SMC.Arit.mult/1,
        "div"=> &GeorgeCompiler.SMC.Arit.div/1
    }

    def artit_exp(operation,s) do
        expression = @operations[operation]
        expression.(s)
    end

    def add(s)do
        {x,y,s} = StackUtils.pop_twice(s)
        Stack.push(s, x+y)
    end

    def mult(s)do
        {x,y,s} = StackUtils.pop_twice(s)
        Stack.push(s, y*x)
    end

    @doc "Subtração e divisão sendo feitas ao contrário para compensar ordem da pilha"
    def sub(s)do
        {x,y,s} = StackUtils.pop_twice(s)
        Stack.push(s, y-x)
    end

    def div(s)do
        {x,y,s} = StackUtils.pop_twice(s)
        Stack.push(s, y/x)
    end

    def is_arit_exp(operation) do
        Map.has_key? @operations, operation
    end

    @doc "Usado para inserir o tipo de operação no topo da pilha antes de empilhar os valores"
    def arit_decompose_tree(tree, c) do
       tree 
       |> push_values(StackUtils.push_as_tree(c, tree.value))
    end

    defp push_values(tree, c) do
        elem = Enum.at(tree.leafs,0)
        if length(tree.leafs) > 1 do
            tree
            |> TreeUtils.remove_first_leaf
            |> push_values(c) 
            |> Stack.push(elem)
        else
            c 
            |> Stack.push(elem)
        end
    end
end