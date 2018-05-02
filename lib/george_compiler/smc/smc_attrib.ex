defmodule GeorgeCompiler.SMC.Attribution do
    
    @doc """
    Aplicação a atribuição retirando de S o valor e o nome da variavel\n
    C := E < m v S, M, := C > ⇒ < S, M [m/v], C >
    """
    def attrib(op, s, m, c) do
        {value, var, s} = StackUtils.pop_twice(s)
        {s, Map.put(m, var, value), c}
    end


    @doc """
    Decomposição da aŕvore de atribuição. \n
    C := I < S, M, v := e C > ⇒ < v S, M, e := C >
    """
    def attribution_decompose_tree(tree, s, m, c) do
        operation = tree.value
        var = Enum.at(tree.leafs, 0)
        value = Enum.at(tree.leafs, 1)

        #Empilha os elementos na pilha C
        {s, m, c 
                |> StackUtils.push_as_tree(operation)
                |> Stack.push(var)
                |> Stack.push(value)}
    end
   
    @doc """
    Recupera o valor de uma variavel dado um mapa M
    """
    def get_variable_value(var, m) do
        m[var]
    end

    @doc """
    Retorna true caso a operação seja attrib.
    """
    def is_attribution(operation), do: operation == "attrib"
end