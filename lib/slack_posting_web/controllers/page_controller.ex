defmodule SlackPostingWeb.PageController do
  use SlackPostingWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
