defmodule SlackPostingWeb.TagController do
  use SlackPostingWeb, :controller

  alias SlackPosting.Journals
  alias SlackPosting.Journals.Tag

  action_fallback SlackPostingWeb.FallbackController

  def index(conn, _params) do
    tags = Journals.list_tags()
    render(conn, "index.json", tags: tags)
  end

  def create(conn, %{"tag" => tag_params}) do
    with {:ok, %Tag{} = tag} <- Journals.create_tag(tag_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", tag_path(conn, :show, tag))
      |> render("show.json", tag: tag)
    end
  end

  def show(conn, %{"id" => id}) do
    tag = Journals.get_tag!(id)
    render(conn, "show.json", tag: tag)
  end

  def update(conn, %{"id" => id, "tag" => tag_params}) do
    tag = Journals.get_tag!(id)

    with {:ok, %Tag{} = tag} <- Journals.update_tag(tag, tag_params) do
      render(conn, "show.json", tag: tag)
    end
  end

  def delete(conn, %{"id" => id}) do
    tag = Journals.get_tag!(id)
    with {:ok, %Tag{}} <- Journals.delete_tag(tag) do
      send_resp(conn, :no_content, "")
    end
  end
end
