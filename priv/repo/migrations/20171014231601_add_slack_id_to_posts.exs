defmodule SlackPosting.Repo.Migrations.AddSlackIdToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add(:slack_id, :string)
    end

    create(index(:posts, [:slack_id]))
  end
end
