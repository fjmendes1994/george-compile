defmodule StackUtilsTest do
    @moduledoc false

    use ExUnit.Case

    test "Duplo pop" do
        stack = Stack.new
                |> Stack.push(5)
                |> Stack.push(2)
        assert StackUtils.pop_twice(stack) == {2, 5, Stack.new}
    end

    test "Inserir na pilha como árvore" do
        stack = Stack.new
        assert StackUtils.push_as_tree(stack, 5) == Stack.new |> Stack.push(Tree.new(5))
    end
end