defmodule GeorgeCompiler.SMC do

    def eval(parse) do
        {_, parsed} = parse
        createC(parsed, Stack.new)
    end 
    
    defp createC(parser, c) when not is_binary(parser) do
        value = Enum.at(parser,0)
        Enum.at(parser,1) |> createC(c) |> Stack.push(value)
    end

    defp createC(parser, c) do
        Stack.push c, parser
    end


end