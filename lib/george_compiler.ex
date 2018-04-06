defmodule GeorgeCompiler do
  @moduledoc """
   Compilador Geroge
  """

  GeorgeCompiler.Parser.parse("10 + -20 - 30 / 40 * 50 % 60") |> IO.inspect()

  # Caindo em recusao infinita cuidado
#  GeorgeCompiler.Parser.parse("1==1") |> IO.inspect()

end
