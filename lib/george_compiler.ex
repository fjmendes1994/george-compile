defmodule GeorgeCompiler do
  @moduledoc """
   Compilador Geroge
  """
  def eval_file(file_content) do
    GeorgeCompiler.Parser.parse!(file_content) #|> IO.inspect()
  end

end
