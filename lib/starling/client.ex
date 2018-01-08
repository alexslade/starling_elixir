defmodule Starling.Client do
  defstruct access_token: nil,
            client_id: nil,
            client_secret: nil,
            expires_in: nil,
            refresh_token: nil,
            token_type: nil,
            user_id: nil

  @type t :: %__MODULE__{
          access_token: String.t(),
          client_id: String.t(),
          client_secret: String.t(),
          expires_in: non_neg_integer(),
          refresh_token: String.t(),
          token_type: String.t(),
          user_id: String.t()
        }

  def personal_access_client(access_token, client_id, client_secret) do
    {:ok, %Starling.Client{
      access_token: access_token,
      client_id: client_id,
      client_secret: client_secret
    }}
  end
end
