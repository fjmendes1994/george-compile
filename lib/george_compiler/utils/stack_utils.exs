defmodule StackUtils do
    @moduledoc """
        Módulo para concentrar operações comuns sobre as pilhas
    """
    def pop_twice(s) do
        {a, s} = Stack.pop(s)
        {b, s} = Stack.pop(s)
        {a, b, s}        
    end

    def push_as_tree(s, value) do
        s
        |> Stack.push(Tree.new(value))
    end
end