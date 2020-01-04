defmodule Servy.BearsController do
  @pages_path Path.expand("../../pages", __DIR__)

  alias Servy.Conv
  alias Servy.Wildthings
  alias Servy.Bear

  import Servy.ViewHelper, only: [render: 3]

  import Servy.FileHandler, only: [handle_file: 2]

  def index(conv) do
    bears =
      Wildthings.list_bears()
      |> Enum.sort(&Bear.order_by_name/2)

    render(conv, "index.eex", bears: bears)
  end

  def show(conv, %{"id" => id}) do
    bear = Wildthings.get_bear(id)

    render(conv, "show.eex", bear: bear)
  end

  def new(conv) do
    @pages_path
    |> Path.join("form.html")
    |> File.read()
    |> handle_file(conv)
  end

  def create(conv, %{"name" => name, "type" => type}) do
    %Conv{
      conv
      | status: 201,
        resp_body: "Created a #{type} bear named #{name}!"
    }
  end

  def delete(conv) do
    %Conv{conv | status: 403, resp_body: "Deleting a bear is forbidden!"}
  end
end
