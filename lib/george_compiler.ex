defmodule GeorgeCompiler do
  @moduledoc """
   Compilador Geroge
  """

  GeorgeCompiler.Parser.parse("-10 - -20 - 30 / 40 * 50 % 60") |> IO.inspect

  # Aqui ta caindo na recursão infinita descobrir porque ( perguntar pro joao)
  GeorgeCompiler.Parser.parse("2 < (1 + 10)") |> IO.inspect

  GeorgeCompiler.Parser.parse("2 + (1 + 10)") |> IO.inspect
end
