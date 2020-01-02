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

    %Conv{
      method: method,
      path: path,
      params: URI.decode_query(params_string)
    }
  end
end
