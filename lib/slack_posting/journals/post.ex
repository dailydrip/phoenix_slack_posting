defmodule SlackPosting.Journals.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias SlackPosting.Journals.Post


  schema "posts" do
    field :user_slack_id, :string
    field :user_name, :string
    field :text, :string

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:text, :user_slack_id, :user_name])
    |> validate_required([:text, :user_slack_id])
  end
end
