defmodule Formals do
  defstruct items: []

  def new(), do: %Formals{}

  def add_par(formals, par) do
    %Formals{formals | items: formals.items ++ [par]}
  end
end

defmodule Par do
  defstruct id: nil, type: nil
  def new(id, type), do: %Par{id: id, type: type}
end