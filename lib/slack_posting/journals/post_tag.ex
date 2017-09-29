defmodule SlackPosting.Journals.PostTag do
  use Ecto.Schema
  import Ecto.Changeset
  alias SlackPosting.Journals.PostTag


  schema "post_tags" do
    belongs_to :post, SlackPosting.Journals.Post
    belongs_to :tag, SlackPosting.Journals.Tag

    timestamps()
  end

  @doc false
  def changeset(%PostTag{} = post_tag, attrs) do
    post_tag
    |> cast(attrs, [:post_id, :tag_id])
    |> validate_required([:post_id, :tag_id])
  end
end
