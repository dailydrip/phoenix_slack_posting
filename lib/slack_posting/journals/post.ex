defmodule SlackPosting.Journals.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias SlackPosting.Journals.Post


  schema "posts" do
    field :slack_id, :string
    field :text, :string

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:text, :slack_id])
    |> validate_required([:text, :slack_id])
  end
end
