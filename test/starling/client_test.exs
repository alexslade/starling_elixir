defmodule Starling.ClientTest do
  use ExUnit.Case
  doctest Starling.Client

  test "personal_access_client/3 returns a new client" do
    access_token = "xyz"

    assert {:ok, %Starling.Client{
             :access_token => ^access_token
           }} = Starling.Client.from_access_token(access_token)
  end
end
