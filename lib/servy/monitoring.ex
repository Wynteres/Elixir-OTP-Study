defmodule Servy.Monitoring do
  @moduledoc """
    Functions to monitor request status and state
  """

  require Logger

  @doc """
    Logs 404 requests.
  """
  def error_track(%{status: 404, path: path} = conv) do
    Logger.warn("Warning: #{path} not found.")
    conv
  end

  @doc """
    Default return
  """
  def error_track(conv), do: conv

  @doc """
    Logs conversation param
  """
  def log(conv), do: IO.inspect(conv)
end
