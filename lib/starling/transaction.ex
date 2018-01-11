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

  def list(client) do
    with {:ok, document} <- Starling.Client.get(client, "api/v1/transactions"),
         transactions <- Enum.map(document.links["transactions"], &decode_transaction/1) do
      {:ok, transactions}
    end
  end

  defp decode_transaction(document) do
    Poison.Decode.decode(document.target.properties, as: %Starling.Transaction{})
  end
end
