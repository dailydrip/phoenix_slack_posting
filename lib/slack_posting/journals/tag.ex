defmodule SlackPosting.Journals.Tag do
  use Ecto.Schema
  import Ecto.Changeset
  alias SlackPosting.Journals.Tag


  schema "tags" do
    field :name, :string
    field :post_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Tag{} = tag, attrs) do
    tag
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
