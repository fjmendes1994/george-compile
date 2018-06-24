defmodule Memory do
  @moduledoc """
  Estrutura que representa a memória
  """
  defstruct store: %{}

  def new() do
    %Memory{}
  end

  def add(memory, value) do
    id = SecureRandom.uuid
    {id, %{memory | store: Map.put(memory.store, id, value)}}
  end

  def set(memory, var, value) do
    if Map.has_key? memory.store, var do
      %{memory | store: Map.put(memory.store, var, value)}
    else
      memory
    end
  end

  def remove(memory, key) do
    %{memory | store: Map.delete(memory.store, key)}
  end

  def get_value(memory, key) do
    memory.store[key]
  end

  def has_key(memory, key) do
    Map.has_key?(memory.store, key)
  end

  def get_free_address(), do: SecureRandom.uuid
end