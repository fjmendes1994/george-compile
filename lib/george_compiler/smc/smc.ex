defmodule GeorgeCompiler.SMC do
	@moduledoc """
	Estrutura que representa a tripla SMC
	"""
	defstruct s: Stack.new, m: Memory.new, c: Stack.new, e: Environment.new

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

	@doc "Retira dois elementos da pilha de valores e retorna os valores e a estrutura SMC sem eles"
	def pop_twice_value(smc) do
		{value_a, value_b, new_s} = StackUtils.pop_twice(smc.s)
		{value_a, value_b, %{smc | s: new_s}}
	end

	@doc "Adiciona valor na pilha de controle em forma de árvore"
	def add_control(smc, value) when is_map(value) do
		%{smc | c: Stack.push(smc.c, value)}
	end

	@doc "Adiciona valor na pilha de controle em forma de árvore"
	def add_control(smc, value) when not is_map(value) do
		%{smc | c: StackUtils.push_as_tree(smc.c, value)}
	end

	@doc "Retira um elemento da pilha de controle e retorna o elemento e a estrutura SMC sem ele"
	def pop_control(smc) do
		{value, new_c} = Stack.pop(smc.c)
		{value, %{smc | c: new_c}}
	end

	@doc "Adiciona um elemento na estrutura de memória ou sobrescreve valores de uma variável"
	def add_store(smc, value) do
		{id, memory} =  Memory.add(smc.m, value)
		{id, %{smc | m: memory}}
	end

	def set_var(smc, var, value) do
		%{smc | m: Memory.set(smc.m, var,value)}
	end

	@doc "Recupera um valor na memória"
	def get_stored_value(smc, id) do
		Memory.get_value(smc.m, id)
	end

	@doc "Limpa a memória"
	def clean_store(smc) do
		%{smc | m: clean(smc.e, smc.m)}
	end

	defp clean(env, store) do
		keys = Enum.filter(env.refs, fn x -> Map.has_key?(store, elem(x,1)) end)
			   |> Enum.map(fn x -> elem x, 1 end)
		Map.take(store, keys)
	end

	def add_reference(smc) do
		{value, var, smc} = pop_twice_value(smc)
		{id, smc} = add_store(smc, value)
		smc = %{smc | e: Environment.add(smc.e, var, id)}
	end

	def add_const(smc) do
		{value, var, smc} = pop_twice_value(smc)
		%{smc | e: Environment.add(smc.e, var, value)}
	end

	def add_const(smc, id, value) do
		%GeorgeCompiler.SMC{smc | e: Environment.add(smc.e, id.value, value)}
	end
end