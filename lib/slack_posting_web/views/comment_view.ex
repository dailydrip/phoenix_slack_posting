defmodule SlackPostingWeb.CommentView do
  use SlackPostingWeb, :view
  alias SlackPostingWeb.CommentView

  def render("index.json", %{comments: comments}) do
    %{data: render_many(comments, CommentView, "comment.json")}
  end

  def render("show.json", %{comment: comment}) do
    %{data: render_one(comment, CommentView, "comment.json")}
  end

  def render("comment.json", %{comment: comment}) do
    %{id: comment.id,
      text: comment.text,
      slack_id: comment.slack_id}
  end
end
