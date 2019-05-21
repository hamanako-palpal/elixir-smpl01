defmodule PhxSs.PageController do
  use PhxSs.Web, :controller

  def index(conn, _params) do

    items = Grnavi.Splitter.splitter
      |> getText([])

    render conn, "index.html", items: items
  end

  def getText([], list) do list end

  def getText([ %{ "surface_form" => word } | tail ], words )do getText(tail, words ++ [ word ] )end

  def updateman(conn, _params) do

    items = Grnavi.Access.makeText("ロシア")

    json conn, items
  end

  def update(conn, %{"key" => key}) do

    items = Grnavi.Access.makeText(key)
    itemsSorted = Enum.sort(items, fn(x, y) -> x[:pcode] < y[:pcode] end)
    # |> Enum.each(fn(i) -> IO.inspect i[:pcode]end)

    json conn, itemsSorted
  end
end
