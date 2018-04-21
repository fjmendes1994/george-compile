defmodule GeorgeCompiler.SMC do

    def eval(parse) do
        {_, parsed} = parse
        createC(Stack.new, parsed, length(parsed)-1)
    end 
    
    defp createC(c, parser, parserLength) when not is_binary(parser) do
        if  parserLength == 0 do
			Stack.push c, Enum.at(parser, parserLength)
		else
			Enum.at(parser,parserLength) |> pushC(c) |> createC(parser,parserLength-1)
		end
	end

    defp pushC(parser, c) do
        Stack.push c, parser
    end
	
	
	
	#============================MÉTODOS ANTIGOS==================================
	"""
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
	"""


end
