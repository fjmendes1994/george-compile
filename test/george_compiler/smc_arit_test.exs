defmodule SMCAritTest do
    @moduledoc false
    
    use ExUnit.Case
    
    test "Adição" do
        assert  create_s() |> GeorgeCompiler.SMC.Arit.add  == Stack.new |> Stack.push(3)   
    end

    test "Subtração" do
        assert create_s() |> GeorgeCompiler.SMC.Arit.sub  == Stack.new |> Stack.push(1)   
    end

    test "Multiplicação" do
        assert create_s() |> GeorgeCompiler.SMC.Arit.mult  == Stack.new |> Stack.push(2)
    end

    test "Divisão" do
        assert create_s() |> GeorgeCompiler.SMC.Arit.div  == Stack.new |> Stack.push(2)   
    end

    def create_s(), do: Stack.new |> Stack.push(2) |> Stack.push(1)

end