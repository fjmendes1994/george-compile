defmodule GeorgeCompiler do
  @moduledoc """
  Documentation for GeorgeCompiler.
  """

  @doc """
  Hello world.

  ## Examples

      iex> GeorgeCompiler.hello
      :world

  """
  def hello do
    :world
  end

  IO.inspect(GeorgeCompiler.Parser.parse("11+ 20 + 30"))

end
