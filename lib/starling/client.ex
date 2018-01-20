defmodule Starling.Client do
  defstruct access_token: nil,
            refresh_token: nil,
            token_type: nil,
            expires_in: nil,
            scope: nil
  use ExConstructor

  @type t :: %__MODULE__{
          access_token: String.t(),
          refresh_token: String.t(),
          token_type: String.t(),
          expires_in: non_neg_integer(),
          scope: String.t()
        }

  def authorize(authorization_code) do
    # TODO: Code review this block. Should client_id be an env_var or passed into the function?
    req_body = %{
      grant_type: :authorization_code,
      client_id: Application.get_env(:starling, :client_id),
      client_secret: Application.get_env(:starling, :client_secret),
      redirect_uri: Application.get_env(:starling, :redirect_uri),
      code: authorization_code
    }

    encoded_body = req_body |> URI.encode_query()
    headers = [{"Content-Type", "application/x-www-form-urlencoded"}]

    case HTTPoison.post(url("oauth/access-token"), encoded_body, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Poison.decode(body, as: %Starling.Client{})

      {:ok, %HTTPoison.Response{status_code: 400, body: body}} ->
        IO.inspect(body)

      {:ok, _response} = resp ->
        resp

      {:error, %HTTPoison.Error{} = err} ->
        err
    end
  end

  def from_access_token(access_token) do
    {:ok, %Starling.Client{
      access_token: access_token
    }}
  end

  def get(client, path) do
    {:ok, doc, _response_header} =
      ExHal.client()
      |> ExHal.Client.add_headers(build_headers(client))
      |> ExHal.Client.get(url(path))

    {:ok, doc}
  end

  defp url(path), do: "#{endpoint()}/#{path}"

  defp endpoint, do: Application.get_env(:starling, :endpoint) || "https://api.starlingbank.com"

  defp build_headers(%{access_token: access_token}) do
    ["User-Agent": "starling-elixir/#{Starling.version()}",
     "Authorization": "Bearer #{access_token}"]
  end
end
