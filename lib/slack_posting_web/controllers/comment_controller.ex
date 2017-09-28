defmodule SlackPostingWeb.CommentController do
  use SlackPostingWeb, :controller

  alias SlackPosting.Journals
  alias SlackPosting.Journals.Comment

  action_fallback SlackPostingWeb.FallbackController

  def index(conn, _params) do
    comments = Journals.list_comments()
    render(conn, "index.json", comments: comments)
  end

  def create(conn, %{"comment" => comment_params}) do
    with {:ok, %Comment{} = comment} <- Journals.create_comment(comment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", comment_path(conn, :show, comment))
      |> render("show.json", comment: comment)
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Journals.get_comment!(id)
    render(conn, "show.json", comment: comment)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Journals.get_comment!(id)

    with {:ok, %Comment{} = comment} <- Journals.update_comment(comment, comment_params) do
      render(conn, "show.json", comment: comment)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Journals.get_comment!(id)
    with {:ok, %Comment{}} <- Journals.delete_comment(comment) do
      send_resp(conn, :no_content, "")
    end
  end
end
