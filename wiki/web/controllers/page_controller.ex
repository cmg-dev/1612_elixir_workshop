defmodule Wiki.PageController do
  use Wiki.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
