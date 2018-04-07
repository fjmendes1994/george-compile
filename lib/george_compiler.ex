defmodule GeorgeCompiler do
  @moduledoc """
   Compilador Geroge
  """

  GeorgeCompiler.Parser.parse("-10 + -20 - 30 / 40 * 50 % 60") |> IO.inspect()


  GeorgeCompiler.Parser.parse("-1==1") |> IO.inspect()

  GeorgeCompiler.Parser.parse("1>=2") |> IO.inspect()

  GeorgeCompiler.Parser.parse("1<=1") |> IO.inspect()

  GeorgeCompiler.Parser.parse("2<1+10") |> IO.inspect()

  GeorgeCompiler.Parser.parse("2!=4") |> IO.inspect()
  
end
