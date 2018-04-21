defmodule GeorgeCompiler do
  @moduledoc """
   Compilador Geroge
  """

    GeorgeCompiler.Parser.parse!("2 * -2 + 2 * 2" )        |> IO.inspect()
    GeorgeCompiler.Parser.parse!("2 > 3" )                             |> IO.inspect()
    GeorgeCompiler.Parser.parse!("2 >= 3" )                            |> IO.inspect()
    GeorgeCompiler.Parser.parse!("2 + 2 == 3 + 2" )                          |> IO.inspect()
    GeorgeCompiler.Parser.parse!("2 < 3" )                             |> IO.inspect()
    GeorgeCompiler.Parser.parse!("2 <= 3" )                            |> IO.inspect()
    GeorgeCompiler.Parser.parse!("abs3as33344dji12j1j1j1j1j1 := 2 + 3 > 2" )                           |> IO.inspect()
#    GeorgeCompiler.Parser.parse!("ab := 2 + 3" )                       |> IO.inspect()
#    GeorgeCompiler.Parser.parse!("ab := 2 > 3" )                       |> IO.inspect()


end
