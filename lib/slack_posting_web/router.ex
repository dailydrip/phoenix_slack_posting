defmodule SlackPostingWeb.Router do
  use SlackPostingWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SlackPostingWeb do
    pipe_through :api
    resources "/posts", PostController, except: [:new, :edit]
  end
end
