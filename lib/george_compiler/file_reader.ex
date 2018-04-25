defmodule GeorgeCompiler.FileReader do
  @moduledoc false

  def readFile(nil, file) do
    case  File.read("examples/#{file}") do
     {:ok, file_content} -> {:ok, file_content}
     {:error, _} -> {:error, "File not found"}
    end
  end

  def readFile(path ,file) do
    case  File.read("#{path}/#{file}") do
     {:ok, file_content} -> {:ok, file_content}
     {:error, _} -> {:error, "File not found"}
    end
  end

end
