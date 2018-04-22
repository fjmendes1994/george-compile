defmodule GeorgeCompiler.SMC.Arit do
    @operations %{  
        "add" => &GeorgeCompiler.SMC.Arit.add/1, 
        "sub" => &GeorgeCompiler.SMC.Arit.sub/1,
        "mul"=> &GeorgeCompiler.SMC.Arit.mult/1,
        "div"=> &GeorgeCompiler.SMC.Arit.div/1
    }

    def artit_exp(operation,s) do
        expression = @operations[operation]
        expression.(s)
    end

    def add(s)do
        {x,y,s} = pop_twice(s)
        Stack.push(s, x+y)
    end

    def mult(s)do
        {x,y,s} = pop_twice(s)
        Stack.push(s, y*x)
    end

    @doc "Subtração e divisão sendo feitas ao contrário para compensar ordem da pilha"
    def sub(s)do
        {x,y,s} = pop_twice(s)
        Stack.push(s, y-x)
    end

    def div(s)do
        {x,y,s} = pop_twice(s)
        Stack.push(s, y/x)
    end

    def is_arit_exp(operation) do
        Map.has_key? @operations, operation
    end

    @doc "Usado para inserir o tipo de operação no topo da pilha antes de empilhar os valores"
    def arit_decompose_tree(tree, c) do
       tree 
       |> push_values(Stack.push(c, Tree.new(tree.value)))
    end

    defp push_values(tree, c) do
        elem = Enum.at(tree.leafs,0)
        if length(tree.leafs) > 1 do
            %{tree | leafs: tree.leafs 
                            |> Enum.drop(1)} 
            |> push_values(c) 
            |> Stack.push(elem)
        else
            c 
            |> Stack.push(elem)
        end
    end

    defp pop_twice(s) do
        {x,s} = Stack.pop(s)
        {y,s} = Stack.pop(s)
        {x,y,s}
    end
end
