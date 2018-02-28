defmodule Starling.TransactionTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest Starling.Transaction

  alias Starling.Transaction

  setup_all do
    HTTPoison.start()
  end

  test "list/1 returns transactions" do
    # All these tests are specific to this cassette - reset as needed.
    use_cassette "transactions/list", match_requests_on: [:query] do
      {:ok, client} =
        Starling.Client.from_access_token(Application.get_env(:starling, :test_access_token))

      {:ok, transactions} = Transaction.list(client)
      assert Enum.count(transactions) == 57
      assert Enum.at(transactions, 0).amount == -3.36
      assert Enum.at(transactions, 54).amount == 2000

      {:ok, transactions} = Transaction.list(client, from: ~D[2018-02-07])
      assert Enum.count(transactions) == 29

      # No transactions in the future yet
      {:ok, transactions} = Transaction.list(client, from: ~D[2019-02-07])
      assert Enum.count(transactions) == 0
    end
  end
end
