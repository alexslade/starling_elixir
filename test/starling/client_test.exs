defmodule Starling.ClientTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest Starling.Client

  test "personal_access_client/3 returns a new client" do
    access_token = "xyz"

    assert {:ok, %Starling.Client{
             :access_token => ^access_token
           }} = Starling.Client.from_access_token(access_token)
  end

  test "authorize/3 with valid code returns a new client" do
    use_cassette "client/authorize" do
      # This uses an example code and response. You'll need to udpate everything when you reset the VCR cassette
      auth_code = "FP0XRWnaGq2x5w64YGouidZ3fjJqCKAoa2aU"

      assert {:ok, %Starling.Client{
               access_token: "hDVDr08nyMk2otUCbfDmLfB5tup4lXup1txs9AcL8GL7FsWgbE38V52spStXrfyR",
               refresh_token: "fkvy6Jnzfi5176AM8dKlpLDxjna1l96Yj2F372oWPrGXUmcRoY7akSR29xDj6znf",
               token_type: "Bearer",
               expires_in: 86400,
               scope:
                 "balance:read mandate:read metadata:create metadata:edit payee:read savings-goal:read savings-goal-transfer:read transaction:read"
             }} = Starling.Client.authorize(auth_code)
    end
  end
end
