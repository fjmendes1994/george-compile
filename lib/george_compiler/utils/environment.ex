defmodule Environment do
  defstruct refs: []

  def new(), do: %Environment{}

  def new(env), do: env

  def add(environment, id, value) do
    %{environment | refs: [{String.to_atom(id), value} | environment.refs]}
  end

  def get_address(environment, ref) do
    Keyword.get(environment.refs, String.to_atom(ref))
  end
end
