defmodule SlackPosting.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :text, :text
      add :slack_id, :string

      timestamps()
    end

  end
end
