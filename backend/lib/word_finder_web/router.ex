defmodule WordFinderWeb.Router do
  use WordFinderWeb, :router

  pipeline :api do
    plug WordFinderWeb.Plugs.RateLimiter
    plug :accepts, ["json"]
  end

  scope "/", WordFinderWeb do
    pipe_through :api

    get("/find_words", WordFinderController, :index)
  end
end
