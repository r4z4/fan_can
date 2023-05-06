defmodule FanCan.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :author, :binary_id
      add :content, :string
      add :upvotes, :integer
      add :downvotes, :integer
      add :thread_id, references(:threads, type: :binary_id, on_delete: :nothing)

      timestamps()
    end

    create index(:posts, [:thread_id])
  end
end
