defmodule Starling.TransactionTest do
  use ExUnit.Case
  doctest Starling.Transaction

  alias Starling.Transaction

  test "list/1 returns transactions" do
    {:ok, client} =
      Starling.Client.personal_access_client(
        Application.get_env(:starling, :personal_access_token),
        Application.get_env(:starling, :client_id),
        Application.get_env(:starling, :client_secret)
      )

    {:ok, transactions} = Transaction.list(client)
    assert Enum.count(transactions) == 93
  end
end
