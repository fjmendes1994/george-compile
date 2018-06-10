defmodule Environment do
    defstruct refs: []

    def new(), do: %Environment{}

    def new(env), do: env

    def add_ref(environment, ref) do
        %{environment | refs: [{String.to_atom(ref), SecureRandom.uuid} | environment.refs]}
    end

    def add_const(environment, id, value) do
        %{environment | refs: [{String.to_atom(id), value} | environment.refs]}
    end

    def get_address(environment, ref) do
        Keyword.get(environment.refs, String.to_atom(ref))
    end

    def get_length(environment) do
        Enum.count(environment.refs)
    end
end