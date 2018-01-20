defmodule Starling.User do
  defstruct uuid: nil

  @type t :: %__MODULE__{
    uuid: String.t()
  }

  def current_user(client) do
    {:ok, document} = Starling.Client.get(client, "api/v1/me")
    user = %__MODULE__{uuid: document.properties["customerUid"]}
    {:ok, user}
  end
end
