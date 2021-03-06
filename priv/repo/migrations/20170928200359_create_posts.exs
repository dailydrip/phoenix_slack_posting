defmodule SlackPosting.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :text, :text
      add :user_slack_id, :string
      add :user_name, :string

      timestamps()
    end

  end
end
