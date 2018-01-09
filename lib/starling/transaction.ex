defmodule Starling.Transaction do
  def list(client) do
    with {:ok, document} <- Starling.Client.get(client, "api/v1/transactions") do
      {:ok, document.links["transactions"]}
    end
  end
end
