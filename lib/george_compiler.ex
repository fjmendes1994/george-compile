defmodule GeorgeCompiler do
  @moduledoc """
   Compilador Geroge
  """

  GeorgeCompiler.Parser.parse!("i := 0;
				                        j := 1;
                                k := 1;
				                        while (k < n) {
                        					t := i + j;
                        					i := j;
                        					j := t;
                                  k := k + 1
                                };
                                print(j)" ) |> IO.inspect()
#    GeorgeCompiler.Parser.parse!("ab := 2 + 3" )                       |> IO.inspect()
#    GeorgeCompiler.Parser.parse!("ab := 2 > 3" )                       |> IO.inspect()


end
