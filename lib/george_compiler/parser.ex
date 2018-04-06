defmodule GeorgeCompiler.Parser do

  use Neotomex.ExGrammar

  @root true


  define :sum, "decimal <space?> <'+'> <space?> sum/ decimal <space?> <'+'> <space?> decimal"

  define :decimal, "[0-9]+/'-'[0-9]+" do
    digitis ->
      Enum.join(digitis)
  end
  define :digit, "[0-9]"

  define :space, "[ \\r\\n\\s\\t]*"
end
