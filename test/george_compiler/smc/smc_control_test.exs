defmodule SMCCommandTest do
    @moduledoc false

    alias GeorgeCompiler.SMC, as: SMC
    import GeorgeCompiler.SMC.Command
    use ExUnit.Case

    test "if sem else" do
        sum = Tree.new("add")
                |> Tree.add_leaf(2)
                |> Tree.add_leaf(2)

        smc = SMC.new
              |> SMC.add_value(nil)
              |> SMC.add_value(sum)
              |> SMC.add_value(sum)
            
        assert if_command(smc) == SMC.new 
                                  |> SMC.add_control(sum)
    end

    test "if com else" do
        sum = Tree.new("add")
                |> Tree.add_leaf(2)
                |> Tree.add_leaf(2)

        sub = Tree.new("sub")
                |> Tree.add_leaf(2)
                |> Tree.add_leaf(2)

        smc = SMC.new
              |> SMC.add_value(sub)
              |> SMC.add_value(sum)
              |> SMC.add_value(false)
        
        result = SMC.new
                 |> SMC.add_control(sub)
            
        assert if_command smc == result
    end
end