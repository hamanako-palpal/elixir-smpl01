defmodule PhxSs.PageController do
  use PhxSs.Web, :controller

  def index(conn, _params) do

    items = Grnavi.Access.makeText
      |> JSX.encode
      |> Grnavi.Access.getDecodes

    render conn, "index.html", items: items
  end
end
