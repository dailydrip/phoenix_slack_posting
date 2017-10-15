defmodule SlackPosting.Journals.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias SlackPosting.Journals.{Comment, Post}


  schema "comments" do
    field :slack_id, :string
    field :text, :string
    belongs_to :post, Post

    timestamps()
  end

  @doc false
  def changeset(%Comment{} = comment, attrs) do
    comment
    |> cast(attrs, [:text, :slack_id])
    |> validate_required([:text, :slack_id])
    |> put_assoc(:post, attrs[:post])
  end
end
