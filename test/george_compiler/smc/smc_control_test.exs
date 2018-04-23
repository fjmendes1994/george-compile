defmodule SMCControlTest do
    @moduledoc false

    import GeorgeCompiler.SMC.Control
    use ExUnit.Case

    test "Atribuição com pilha s" do
        s = Stack.new
            |> Stack.push("var")
            |> Stack.push(5)
        m = %{"var" => 5}

        assert atrib(s, %{}, Stack.new) == {Stack.new, m, Stack.new}
    end

    
end