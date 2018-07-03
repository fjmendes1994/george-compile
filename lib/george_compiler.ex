defmodule GeorgeCompiler do
  @moduledoc """
   Compilador Geroge
  """
  def eval_file(file_content, verbose) do
    case {file_content, verbose} do
    {file_content, "parser"} ->
      GeorgeCompiler.Parser.parse!(file_content)
      |> IO.inspect
      |> start_smc(verbose)
      |> IO.inspect

    {file_content, "smc"} ->
      GeorgeCompiler.Parser.parse!(file_content)
      |> IO.inspect
      |> start_smc(verbose)
      |> IO.inspect

    {file_content, "all"} ->
      GeorgeCompiler.Parser.parse!(file_content)
      |> IO.inspect
      |> start_smc("smc")
      |> IO.inspect

    _ -> GeorgeCompiler.Parser.parse!(file_content)
        |> start_smc(verbose)
        |> IO.inspect
  end
  end



  defp start_smc(tree, verbose) do
    GeorgeCompiler.SMC.new
    |> GeorgeCompiler.SMC.add_control(tree)
    |> GeorgeCompiler.Compiler.evaluate(verbose)
  end
end
