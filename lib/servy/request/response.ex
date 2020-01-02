defmodule Servy.Request.Response do
  @moduledoc """
    Functions to format response
  """

  alias Servy.Conv

  @doc """
    Formats response according to conversation map
  """
  def format_response(%Conv{} = conv) do
    # TODO: Use values in the map to create an HTTP response string:
    """
    HTTP/1.1 #{Conv.full_status(conv)}
    Content-Type: text/html
    Content-Length: #{String.length(conv.resp_body)}

    #{conv.resp_body}
    """
  end
end
