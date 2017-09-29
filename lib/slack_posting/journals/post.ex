defmodule SlackPosting.Journals.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias SlackPosting.Journals.Post

  schema "posts" do
    field :user_slack_id, :string
    field :user_name, :string
    field :text, :string
    many_to_many :tags, SlackPosting.Journals.Tag, join_through: SlackPosting.Journals.PostTag
    has_many :comments, SlackPosting.Journals.Comment

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:text, :user_slack_id, :user_name])
    |> validate_required([:text, :user_slack_id])
  end
end
