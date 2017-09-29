require IEx
defmodule SlackPostingWeb.PostView do
  use SlackPostingWeb, :view
  alias SlackPostingWeb.PostView

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    %{id: post.id,
      text: post.text,
      user_slack_id: post.user_slack_id,
      user_name: post.user_name,
      tags: Enum.map(post.tags, fn tag -> render("tag.json", %{tag: tag}) end)
    }
  end

  def render("tag.json", %{tag: tag}) do
    %{
      id: tag.id,
      name: tag.name
    }
  end
end
