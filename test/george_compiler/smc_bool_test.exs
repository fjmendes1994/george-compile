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

    test "maior que" do
        s = Stack.new |> Stack.push(5) |> Stack.push(3) 
        assert greater_than(s) == Stack.new |> Stack.push(true)
    end

    test "menor que" do
        s = Stack.new |> Stack.push(3) |> Stack.push(5) 
        assert lesser_than(s) == Stack.new |> Stack.push(true)
    end

    test "maior igual que" do
        s = Stack.new |> Stack.push(5) |> Stack.push(5) 
        assert greater_equals_than(s) == Stack.new |> Stack.push(true)
    end

    test "menor igual que" do
        s = Stack.new |> Stack.push(5) |> Stack.push(5) 
        assert lesser_equals_than(s) == Stack.new |> Stack.push(true)
    end
end