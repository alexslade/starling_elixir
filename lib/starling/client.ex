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

  def get(client, path, params \\ :empty) do
    request(client, :get, path, params)
  end

  defp request(client, method, path, params \\ :empty, body \\ "", headers \\ []) do
    url = url(path, params)

    headers =
      headers
      |> put_headers_default
      |> put_headers_access_token(client)

    case HTTPoison.request(method, url, body, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}

      {:ok, %HTTPoison.Response{} = error} ->
        {:error, error}

      {:error, %HTTPoison.Error{} = error} ->
        {:error, error}
    end
  end

  defp url(path, :empty), do: "#{Application.get_env(:starling, :endpoint)}/#{path}"

  defp url(path, params) do
    uri =
      url(path, :empty)
      |> URI.parse()
      |> Map.put(:query, Plug.Conn.Query.encode(params))

    URI.to_string(uri)
  end

  defp put_headers_default(headers) do
    [{"User-Agent", "starling-elixir/#{Starling.version()}"} | headers]
  end

  defp put_headers_access_token(headers, nil), do: headers
  defp put_headers_access_token(headers, %{access_token: nil}), do: headers

  defp put_headers_access_token(headers, %{access_token: access_token}) do
    [{"Authorization", "Bearer #{access_token}"} | headers]
  end
end
