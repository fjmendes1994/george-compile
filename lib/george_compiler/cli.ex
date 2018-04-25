defmodule GeorgeCompiler.CLI do
  @moduledoc false

  def main(args) do
   args |> parse_args |> process
  end

  def process([]) do
    IO.puts "No arguments given"
  end

  def process(options) do
      case GeorgeCompiler.FileReader.readFile(options[:path],options[:file]) do
        {:ok, file_content} -> GeorgeCompiler.eval_file(file_content)
        {:error, msg} -> IO.inspect msg
      end
  end

  defp parse_args(args) do
   {options, _, _} = OptionParser.parse(args, switches: [file: :string, path: :string])
   options
  end


end
