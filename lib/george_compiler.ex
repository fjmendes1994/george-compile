defmodule GeorgeCompiler do
  @moduledoc """
   Compilador Geroge
  """
  def eval_file(file_content) do
    GeorgeCompiler.Parser.parse!(file_content) 
    #|> IO.inspect 
    |> start_smc 
    |> IO.inspect
  end


  defp start_smc(tree) do
    GeorgeCompiler.SMC.new 
    |> GeorgeCompiler.SMC.add_control(tree)
    |> GeorgeCompiler.Compiler.evaluate
  end
end
