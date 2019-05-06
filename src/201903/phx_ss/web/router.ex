defmodule PhxSs.Router do
  use PhxSs.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug
  end

  scope "/", PhxSs do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/", PhxSs do
    pipe_through :api # Use the default browser stack

    get "/update",  PageController, :update
    get "/update/:key",  PageController, :update
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhxSs do
  #   pipe_through :api
  # end
end
