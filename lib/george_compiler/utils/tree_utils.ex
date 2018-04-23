defmodule TreeUtils do
    def remove_first_leaf(tree) do
        %{tree | leafs: tree.leafs 
                        |> Enum.drop(1)}
    end
end