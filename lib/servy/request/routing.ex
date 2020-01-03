defmodule Servy.Request.Routing do
  @moduledoc """
    Functions to Route incoming request
  """

  alias Servy.Conv
  alias Servy.BearsController

  @pages_path Path.expand("../../pages", __DIR__)

  import Servy.FileHandler, only: [handle_file: 2]

  def route(%Conv{method: "GET", path: "/wildthings"} = conv) do
    %Conv{conv | status: 200, resp_body: "Bears, Lions, Tigers"}
  end

  def route(%Conv{method: "GET", path: "/bears"} = conv) do
    BearsController.index(conv)
  end

  def route(%Conv{method: "GET", path: "/bears/new"} = conv) do
    BearsController.new(conv)
  end

  def route(%Conv{method: "GET", path: "/bears/" <> id} = conv) do
    params = Map.put(conv.params, "id", id)
    BearsController.show(conv, params)
  end

  def route(%Conv{method: "POST", path: "/bears"} = conv) do
    BearsController.create(conv, conv.params)
  end

  def route(%Conv{method: "DELETE", path: "/bears/" <> _id} = conv) do
    BearsController.delete(conv)
  end

  def route(%Conv{method: "GET", path: "/about"} = conv) do
    @pages_path
    |> Path.join("about.html")
    |> File.read()
    |> handle_file(conv)
  end

  def route(%Conv{method: "GET", path: "/pages/" <> page_name} = conv) do
    @pages_path
    |> Path.join("#{page_name}.html")
    |> File.read()
    |> handle_file(conv)
  end

  def route(%Conv{method: method, path: path} = conv) do
    %Conv{conv | status: 404, resp_body: "#{method} for #{path} not found."}
  end
end
