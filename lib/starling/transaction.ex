defmodule Starling.Transaction do
  def list(client) do
    with {:ok, json} <- Starling.Client.get(client, "api/v1/transactions"),
         {:ok, resource} <- Poison.decode(json) do
      {:ok, resource["_embedded"]["transactions"]}
    end
  end
end
