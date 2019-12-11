defmodule PhxSs.PageController do
  use PhxSs.Web, :controller

  def index(conn, _params) do

    items = "浜谷と春日は力技と思いきやめちゃくちゃ上手い"
        |> Grnavi.Splitter.splitText

    render conn, "index.html", items: items
  end

  def update(conn, %{"key" => key}) do

    items = Grnavi.Access.makeText(key)
    # itemsSorted = Enum.sort(items, fn(x, y) -> x[:pcode] < y[:pcode] end)
    # # |> Enum.each(fn(i) -> IO.inspect i[:pcode]end)

    json conn, items
  end
end
