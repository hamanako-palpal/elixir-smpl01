defmodule PhxSs.PageController do
  use PhxSs.Web, :controller

  def index(conn, _params) do

    items = Grnavi.Access.makeText
      #|> JSX.encode
      #|> Grnavi.Access.getDecodes

      #send_resp(conn, 200, items)
    #render conn, "index.html", items: items
    json conn, items
  end
end
