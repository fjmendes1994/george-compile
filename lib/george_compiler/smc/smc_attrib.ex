defmodule GeorgeCompiler.SMC.Attribution do
    
    @doc """
    Aplicação da atribuição retirando de S o valor e o nome da variavel para colocá-los no mapa M\n
    C := E < m v S, M, := C > ⇒ < S, M [m/v], C >
    """
    def attrib(_, s, m, c) do
        {value, var, s} = StackUtils.pop_twice(s)
        {s, Map.put(m, var, value), c}
    end


    @doc """
    Decomposição da aŕvore de atribuição. \n
    C := I < S, M, v := e C > ⇒ < v S, M, e := C >
    """
    def attribution_decompose_tree(tree, s, m, c) do
        operation = tree.value
        #Recupera o nome da variavel usando pattern matching
        %Tree{leafs: _, value: var} = Enum.at(tree.leafs, 0)
        value = Enum.at(tree.leafs, 1)

        #Empilha o nome da variavel em S
        s = s 
            |> Stack.push(var)
        #Empilha o valor e o operador em C
        c = c 
            |> StackUtils.push_as_tree(operation)
            |> Stack.push(value)
        {s, m, c}
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
    def is_attribution(operation), do: operation == :attrib
end