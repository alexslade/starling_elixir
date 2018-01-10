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
        Starling.Client.personal_access_client(
          Application.get_env(:starling, :personal_access_token),
          Application.get_env(:starling, :client_id),
          Application.get_env(:starling, :client_secret)
        )

      {:ok, transactions} = Transaction.list(client)
      assert Enum.count(transactions) == 32
    end
  end
end
