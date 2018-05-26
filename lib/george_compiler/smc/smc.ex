defmodule GeorgeCompiler.SMC do
	@moduledoc """
	Estrutura que representa a tripla SMC
	"""
	defstruct s: Stack.new, m: %{}, c: Stack.new

	@doc "Gera uma tripla SMC com duas stacks(valores e controle) e um map(memória)"
	def new(), do: %GeorgeCompiler.SMC{}

	@doc "Adiciona valor na pilha de valores"
	def add_value(smc, value) do
		%{smc | s: Stack.push(smc.s, value)}
	end

	@doc "Retira um elemento da pilha de valores e retorna o valor e a estrutura SMC sem ele"
	def pop_value(smc) do
		{value, new_s} = Stack.pop(smc.s)
		{value, %{smc | s: new_s}}
	end

	@doc "Adiciona valor na pilha de controle em forma de árvore"
	def add_control(smc, value) do
		%{smc | c: StackUtils.push_as_tree(smc.c, value)}
	end

	@doc "Retira um elemento da pilha de controle e retorna o elemento e a estrutura SMC sem ele"
	def pop_control(smc) do
		{value, new_c} = Stack.pop(smc.c)
		{value, %{smc | c: new_c}}
	end

	@doc "Adiciona um elemento na estrutura de memória ou sobrescreve valores de uma variável"
	def add_store(smc, key, value) do
		%{smc | m: Map.put(smc.m, key, value)}
	end

	@doc "Limpa a memória"
	def clean_store(smc) do
		%{smc | m: %{}}
	end
end