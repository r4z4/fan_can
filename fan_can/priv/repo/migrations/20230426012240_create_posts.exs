defmodule FanCan.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :author, :binary
      add :content, :string
      add :likes, :integer
      add :shares, :integer
      add :thread, references(:threads, type: :binary_id, on_delete: :nothing)

      timestamps()
    end

    create index(:posts, [:thread])
  end
end
