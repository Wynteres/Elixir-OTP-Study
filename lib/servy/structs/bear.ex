defmodule Servy.Bear do
  defstruct id: nil,
            name: "",
            type: "",
            hibernating: false

  def order_by_name(current_bear, next_bear) do
    current_bear.name <= next_bear.name
  end
end
