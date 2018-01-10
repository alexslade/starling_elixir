defmodule Starling.TransactionTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest Starling.Transaction

  alias Starling.Transaction

  setup_all do
    HTTPoison.start
  end

  test "list/1 returns transactions" do
    use_cassette "transactions/list" do
      {:ok, client} =
        Starling.Client.from_access_token(
          Application.get_env(:starling, :sandbox_access_token)
        )

      {:ok, transactions} = Transaction.list(client)
      assert Enum.count(transactions) == 32
    end
  end
end
