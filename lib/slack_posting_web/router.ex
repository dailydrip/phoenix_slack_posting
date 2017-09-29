defmodule SlackPostingWeb.Router do
  use SlackPostingWeb, :router
  use ExAdmin.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SlackPostingWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
   scope "/api", SlackPostingWeb do
     pipe_through :api
     resources "/comments", CommentController, except: [:new, :edit]
     resources "/posts", PostController, except: [:new, :edit]
     resources "/tags", TagController, except: [:new, :edit]
   end


  # your app's routes
  scope "/admin", ExAdmin do
    pipe_through :browser
    admin_routes()
  end
end
