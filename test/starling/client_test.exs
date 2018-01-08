defmodule Starling.ClientTest do
  use ExUnit.Case
  doctest Starling.Client

  test "personal_access_client/3 returns a new client" do
    client_id = "123"
    client_secret = "123abc"
    access_token = "xyz"

    assert {:ok, %Starling.Client{
             :client_id => ^client_id,
             :client_secret => ^client_secret,
             :access_token => ^access_token
           }} = Starling.Client.personal_access_client(access_token, client_id, client_secret)
  end
end
