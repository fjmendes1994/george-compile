defmodule TreeUtilsTest do
    @moduledoc false

    use ExUnit.Case

    test "Retira primeira folha" do
        tree = Tree.new 
                |> Tree.add_leaf(5)
                |> Tree.add_leaf(4)
        new_tree = Tree.new
                    |> Tree.add_leaf(4)
        assert TreeUtils.remove_first_leaf(tree) == new_tree
    end
end