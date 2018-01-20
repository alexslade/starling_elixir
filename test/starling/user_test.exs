defmodule Starling.UserTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest Starling.User
  alias Starling.User

  setup_all do
    HTTPoison.start()
  end

  test "current_user/1 returns a user" do
    use_cassette "user/current_user" do
      {:ok, client} =
        Starling.Client.from_access_token(Application.get_env(:starling, :test_access_token))

      {:ok, user} = User.current_user(client)

      assert user.uuid == "035a36ff-8aae-4d37-8d9d-fccd45969c18"
    end
  end
end
