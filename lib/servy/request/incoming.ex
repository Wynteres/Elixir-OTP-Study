defmodule Servy.Request.Incoming do
  @moduledoc """
    Functions to treat incoming requests before routing
  """

  alias Servy.Conv

  @doc """
    Rewrites path to /wildlife redirects to /wildthings
  """
  def rewrite_path(%{path: "/wildlife"} = conv) do
    %{conv | path: "/wildthings"}
  end

  @doc """
    Default return
  """
  def rewrite_path(conv), do: conv

  @doc """
    Parses incoming requet to a conversation map
  """
  def parse(request) do
    [settings, params_string] = String.split(request, "\n\n")

    [request_line | headers] = String.split(settings, "\n")

    [method, path, _] = String.split(request_line, " ")

    headers = parse_headers(headers, %{})

    IO.inspect(headers)

    params = parse_params(headers["Content-Type"], params_string)
    IO.inspect(params)

    %Conv{
      method: method,
      path: path,
      params: params,
      headers: headers
    }
  end

  defp parse_headers([head | tail], headers) do
    [key, value] = String.split(head, ": ")

    headers = Map.put(headers, key, value)

    parse_headers(tail, headers)
  end

  defp parse_headers([], headers), do: headers

  defp parse_params("application/x-www-form-urlencoded", params_string) do
    params_string |> String.trim() |> URI.decode_query()
  end

  defp parse_params(_, _), do: %{}
end
