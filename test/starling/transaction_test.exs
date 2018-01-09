defmodule Starling.TransactionTest do
  use ExUnit.Case
  doctest Starling.Transaction

  alias Starling.Transaction

  test "list/1 returns transactions" do
    {:ok, client} =
      Starling.Client.personal_access_client(
        "qrynyLp5eFfYadq5rVSTCw16U8k2pqvJe1CN2X3GJ9mZunnhxtrSdSkWtoMFDKi2", # TODO: don't commit these
        "lvZ9lt6xDSyWSjxYz4tE",
        "FmfJttxxpR1StXb2eA7nNobKsNBLPR1Pat2wzwS1"
      )

    {:ok, transactions} = Transaction.list(client)
    assert Enum.count(transactions) == 93
  end
end
