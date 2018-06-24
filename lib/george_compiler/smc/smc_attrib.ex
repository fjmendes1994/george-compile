defmodule GeorgeCompiler.SMC.Attribution do
    
    alias GeorgeCompiler.SMC, as: SMC

    @doc """
    Aplicação da atribuição retirando de S o valor e o nome da variavel para colocá-los no mapa M\n
    C := E < m v S, M, := C > ⇒ < S, M [m/v], C >
    """
    def attrib(_, smc) do
        {value, var, smc} = SMC.pop_twice_value(smc)
        x = Environment.get_address(smc.e, var)
        if Memory.has_key smc.m, x do
            SMC.set_var(smc, x, get_variable_value(value, smc))
        else
            if Environment.get_address(smc.e, var) == nil do
                raise "Variável nao encontrada"  
            end 
            smc
        end
    end

    @doc """
    Decomposição da aŕvore de atribuição. \n
    C := I < S, M, v := e C > ⇒ < v S, M, e := C >
    """
    def attribution_decompose_tree(tree, smc) do
        operation = tree.value
        #Recupera o nome da variavel usando pattern matching
        %Tree{leafs: _, value: var} = Enum.at(tree.leafs, 0)
        value = Enum.at(tree.leafs, 1)

        smc
        |> SMC.add_value(var)
        |> SMC.add_control(operation)
        |> SMC.add_control(value)
    end
   
    @doc """
    Recupera o valor de uma variavel dado um mapa M
    """
    def get_variable_value(var, _) when not is_binary(var) do
        var
    end

    def get_variable_value(var, smc) when is_binary(var) do
        x = Environment.get_address(smc.e, var)
        if x do
            if Memory.has_key smc.m, x do
                SMC.get_stored_value smc, x
            else
                x
            end
        else
            nil
        end
    end

    @doc """
    Retorna true caso a operação seja attrib.
    """
    def is_attribution(operation), do: operation == :attrib
end