defmodule Stack do
    @moduledoc """
        Módulo genério de pilha utilizado no SMC.
        Copiado de https://onor.io/2014/06/02/a-naive-stack-implementation-in-elixir-2/
    """ 
    defstruct elements: []
     
    def new, do: %Stack{}
     
    def push(stack, element) do
        %Stack{stack | elements: [element | stack.elements]}
    end
     
    def pop(%Stack{elements: []}), do: raise("Stack is empty!")

    def pop(%Stack{elements: [top | rest]}) do
        {top, %Stack{elements: rest}}
    end
     
    def depth(%Stack{elements: elements}), do: length(elements)
end