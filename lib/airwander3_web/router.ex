defmodule Airwander3Web.Router do
  use Airwander3Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {Airwander3Web.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Airwander3Web do
    pipe_through :browser

    live "/", TourLive.Index, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Airwander3Web do
  #   pipe_through :api
  # end
end
