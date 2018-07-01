defmodule ABSTest do
    @moduledoc false

    use ExUnit.Case

    test "Novo abs com formals" do
        assert ABS.new(["formals", Tree.new(:blk)]) == %ABS{formals: "formals", block: Tree.new(:blk)}
    end

    test "Novo abs sem formals" do
        assert ABS.new([Tree.new(:blk)]) == %ABS{block: Tree.new(:blk)}
    end

    test "Adicionando declaração ao bloco" do
        abs = ABS.new([["var"], Tree.new(:blk) |> Tree.add_leaf(Tree.new(:decl)) |> Tree.add_leaf(Tree.new(:seq))])
        assert ABS.add_dec(abs, Stack.new() |> Stack.push(2)) == %Tree{
                                                                        leafs: [
                                                                        %Tree{
                                                                            leafs: [
                                                                            %Tree{
                                                                                leafs: [
                                                                                %Tree{leafs: [], value: "var"},
                                                                                %Tree{leafs: [], value: 2}
                                                                                ],
                                                                                value: :ref
                                                                            }
                                                                            ],
                                                                            value: :decl
                                                                        },
                                                                        %Tree{leafs: [], value: :seq}
                                                                        ],
                                                                        value: :blk
                                                                    }
    end

    test "Adicionando declaração ao bloco sem declaração prévia" do
        abs = ABS.new([["var"], Tree.new(:blk) |> Tree.add_leaf(Tree.new(:seq))])
        assert ABS.add_dec(abs, Stack.new() |> Stack.push(2)) == %Tree{
                                                                        leafs: [
                                                                        %Tree{
                                                                            leafs: [
                                                                            %Tree{
                                                                                leafs: [
                                                                                %Tree{leafs: [], value: "var"},
                                                                                %Tree{leafs: [], value: 2}
                                                                                ],
                                                                                value: :ref
                                                                            }
                                                                            ],
                                                                            value: :decl
                                                                        },
                                                                        %Tree{leafs: [], value: :seq}
                                                                        ],
                                                                        value: :blk
                                                                    }
    end
end