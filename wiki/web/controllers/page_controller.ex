defmodule Wiki.PageController do
  use Wiki.Web, :controller

  def index(conn, _params) do
    pages = [
      %{title: "Main Page", body: "Welcome"},
    ]
    render conn, "index.html", pages: pages
  end

end
