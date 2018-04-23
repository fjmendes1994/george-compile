defmodule TreeUtils do
    def remove_first_leaf(tree) do
        %{tree | leafs: tree.leafs 
                        |> Enum.drop(1)}
    end

    def is_nil(tree) do
        tree.value == nil
    end
end