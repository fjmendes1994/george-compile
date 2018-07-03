defmodule ActualsTest do
  @moduledoc false

  use ExUnit.Case
  import Actuals

  test "Pegando valores" do
    tree_add = Tree.new(:add) 
              |> Tree.add_leaf(3) 
              |> Tree.add_leaf(2)
    tree_bool = Tree.new(:eq)
                |> Tree.add_leaf(3)
                |> Tree.add_leaf(2)
    assert get_values(%Actuals{items: [tree_add, tree_bool]}) == Stack.new |> Stack.push(5) |> Stack.push(false)
  end
end