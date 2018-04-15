defmodule GeorgeCompiler do
  @moduledoc """
   Compilador Geroge
  """

  GeorgeCompiler.Parser.parse!("2 + 2 - -2" ) |> IO.inspect
  GeorgeCompiler.Parser.parse!("2 > 3" ) |> IO.inspect
  GeorgeCompiler.Parser.parse!("ab := 3" ) |> IO.inspect

end
