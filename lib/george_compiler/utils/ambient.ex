defmodule Ambient do
    defstruct refs: []

    def new(), do: %Ambient{}

    def add_ref(ambient, ref) do
        %{ambient | refs: [{String.to_atom(ref), SecureRandom.uuid} | ambient.refs]}
    end

    def get_address(ambient, ref) do
        Keyword.get(ambient.refs, String.to_atom(ref))
    end

    def get_length(ambient) do
        Enum.count(ambient.refs)
    end
end