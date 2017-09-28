defmodule SlackPosting.Journals.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias SlackPosting.Journals.Comment


  schema "comments" do
    field :slack_id, :string
    field :text, :string
    field :post_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Comment{} = comment, attrs) do
    comment
    |> cast(attrs, [:text, :slack_id])
    |> validate_required([:text, :slack_id])
  end
end
