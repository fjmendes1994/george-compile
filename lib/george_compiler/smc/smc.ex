defmodule GeorgeCompiler.SMC do
    defstruct s: Stack.new, m: %{}, c: Stack.new

    def new() , do: %GeorgeCompiler.SMC{}

    def add_value(smc, value) do
        %{smc | s: Stack.push(smc.s, value)}
    end
end