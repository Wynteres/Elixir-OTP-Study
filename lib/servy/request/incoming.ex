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
    [method, path | _] =
      request
      |> String.split("\n")
      |> List.first()
      |> String.split(" ")

    %Conv{
      method: method,
      path: path,
      resp_body: "",
      status: nil
    }
  end
end
