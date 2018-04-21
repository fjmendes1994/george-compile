defmodule SMCBoolTest do
    @moduledoc false

    use ExUnit.Case

    import GeorgeCompiler.SMC.Bool

    test "igualdade" do
        s = Stack.new |> Stack.push(5) |> Stack.push(5) 
        assert equals(s) == Stack.new |> Stack.push(true)
    end
    
    test "negação" do
        s = Stack.new |> Stack.push(true) 
        assert nt(s) == Stack.new |> Stack.push(false)
    end

    #Expressão: !(5==5)
    test "negação e igualdade" do
        s = Stack.new |> Stack.push(5) |> Stack.push(5)
        assert equals(s) |> nt == Stack.new |> Stack.push(false)
    end
end