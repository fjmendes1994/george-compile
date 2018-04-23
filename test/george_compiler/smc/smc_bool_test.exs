defmodule SMCBoolTest do
    @moduledoc false

    use ExUnit.Case

    import GeorgeCompiler.SMC.Bool

    test "igualdade" do
        s = Stack.new 
            |> Stack.push(5) 
            |> Stack.push(5) 
        assert equals(s, %{}) == Stack.new |> Stack.push(true)
    end
    
    test "negação" do
        s = Stack.new 
            |> Stack.push(true) 
        assert nt(s, %{}) == Stack.new |> Stack.push(false)
    end

    #Expressão: !(5==5)
    test "negação e igualdade" do
        s = Stack.new 
            |> Stack.push(5) 
            |> Stack.push(5)
        assert equals(s, %{}) |> nt(%{}) == Stack.new |> Stack.push(false)
    end

    @doc "Testes para > e <"
    test "maior que verdadeiro" do
        s = Stack.new 
            |> Stack.push(5) 
            |> Stack.push(3) 
        assert greater_than(s, %{}) == Stack.new |> Stack.push(true)
    end

    test "menor que verdadeiro" do
        s = Stack.new 
            |> Stack.push(3) 
            |> Stack.push(5) 
        assert lesser_than(s, %{}) == Stack.new |> Stack.push(true)
    end

    test "maior que falso" do
        s = Stack.new 
            |> Stack.push(3) 
            |> Stack.push(5) 
        assert greater_than(s, %{}) == Stack.new |> Stack.push(false)
    end

    test "menor que falso" do
        s = Stack.new 
            |> Stack.push(5) 
            |> Stack.push(3) 
        assert lesser_than(s, %{}) == Stack.new |> Stack.push(false)
    end

    @doc "testes para >= e <="
    # MAIOR OU IGUAL
    test "maior igual que verdadeiro" do
        s = Stack.new 
            |> Stack.push(5) 
            |> Stack.push(5) 
        assert greater_equals_than(s, %{}) == Stack.new |> Stack.push(true)
    end

    test "maior igual que verdadeiro 2" do
        s = Stack.new 
            |> Stack.push(6) 
            |> Stack.push(5) 
        assert greater_equals_than(s, %{}) == Stack.new |> Stack.push(true)
    end

    test "maior igual que falso" do
        s = Stack.new 
            |> Stack.push(6) 
            |> Stack.push(7) 
        assert greater_equals_than(s, %{}) == Stack.new |> Stack.push(false)
    end

    #MENOR OU IGUAL
    test "menor igual que verdadeiro" do
        s = Stack.new 
            |> Stack.push(5) 
            |> Stack.push(5) 
        assert lesser_equals_than(s, %{}) == Stack.new |> Stack.push(true)
    end

    test "menor igual que verdadeiro 2" do
        s = Stack.new 
            |> Stack.push(3) 
            |> Stack.push(5) 
        assert lesser_equals_than(s, %{}) == Stack.new |> Stack.push(true)
    end

    test "menor igual que falso" do
        s = Stack.new 
            |> Stack.push(5) 
            |> Stack.push(4) 
        assert lesser_equals_than(s, %{}) == Stack.new |> Stack.push(false)
    end


    @doc "AND e OR"
    test "teste de and verdadeiro" do
        s = Stack.new 
            |> Stack.push(true) 
            |> Stack.push(true) 
        assert bool_and(s, %{}) == Stack.new |> Stack.push(true)
    end

    test "teste de and falso" do
        s = Stack.new 
            |> Stack.push(true)
            |> Stack.push(false) 
        assert bool_and(s, %{}) == Stack.new |> Stack.push(false)
    end

    test "teste de or verdadeiro" do
        s = Stack.new 
            |> Stack.push(true)
            |> Stack.push(false) 
        assert bool_or(s, %{}) == Stack.new |> Stack.push(true)
    end

    test "teste de or falso" do
        s = Stack.new 
            |> Stack.push(false) 
            |> Stack.push(false) 
        assert bool_or(s, %{}) == Stack.new |> Stack.push(false)
    end
end