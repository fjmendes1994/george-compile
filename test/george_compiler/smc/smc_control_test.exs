defmodule SMCControlTest do
    @moduledoc false

    import GeorgeCompiler.SMC.Command
    use ExUnit.Case

    test "Atribuição com pilha s" do
        s = Stack.new
            |> Stack.push("var")
            |> Stack.push(5)
        m = %{"var" => 5}

        assert atrib(s, %{}, Stack.new) == {Stack.new, m, Stack.new}
    end

    test "if sem else" do
        sum = Tree.new("add")
                |> Tree.add_leaf(2)
                |> Tree.add_leaf(2)

        s = Stack.new
            |> Stack.push(nil)    
            |> Stack.push(sum)
            |> Stack.push(true)
            
        assert if_control(s, %{}, Stack.new) == {Stack.new, %{}, Stack.new |> Stack.push(sum) }
    end

    test "if com else" do
        sum = Tree.new("add")
                |> Tree.add_leaf(2)
                |> Tree.add_leaf(2)

        sub = Tree.new("sub")
                |> Tree.add_leaf(2)
                |> Tree.add_leaf(2)

        s = Stack.new
            |> Stack.push(sub)
            |> Stack.push(sum)    
            |> Stack.push(false)
            
        assert if_control(s, %{}, Stack.new) == {Stack.new, %{}, Stack.new |> Stack.push(sub)}
    end
end