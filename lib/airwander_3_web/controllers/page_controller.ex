defmodule Airwander3Web.PageController do
  use Airwander3Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
