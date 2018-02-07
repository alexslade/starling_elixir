defmodule Starling.Transaction do
  defstruct id: nil,
            amount: nil,
            balance: nil,
            created: nil,
            currency: nil,
            direction: nil,
            narrative: nil,
            source: nil

  @type t :: %__MODULE__{
          id: String.t(),
          amount: String.t(),
          balance: Float.t(),
          created: String.t(),
          currency: String.t(),
          direction: String.t(),
          narrative: String.t(),
          source: String.t()
        }

  def list(client, opts \\ []) do
    url = list_url(from: Keyword.get(opts, :from))

    with {:ok, document} <- Starling.Client.get(client, url),
         transactions <- decode_transactions(document.links["transactions"]) do
      {:ok, transactions}
    end
  end

  defp list_url(from: nil) do
    "api/v1/transactions"
  end

  defp list_url(from: from) do
    list_url(from: nil) <> "?" <> URI.encode_query(from: from)
  end

  defp decode_transactions(nil), do: []

  defp decode_transactions(transactions) do
    Enum.map(transactions, fn document ->
      Poison.Decode.decode(document.target.properties, as: %Starling.Transaction{})
    end)
  end
end
