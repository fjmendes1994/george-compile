defmodule GeorgeCompiler.BPLC do

  def toBPLC(:arithmeticOps) do

    %{"+" => "add",
      "-" => "sub",
      "*" => "mul",
      "/" => "div"}

  end

  def toBPLC(:booleanOps) do

    %{">" => "gt",
      ">=" => "ge",
      "<" => "lt",
      "<=" => "le",
      "==" => "eq",
      "!=" => "neg"}

  end

  #iex> GeorgeCompiler.BPLC.toBPLC(:arithmeticOps)["+"]
  #     add

end
