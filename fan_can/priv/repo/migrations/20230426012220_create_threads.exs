defmodule FanCan.Repo.Migrations.CreateThreads do
  use Ecto.Migration

  def change do
    create table(:threads, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :creator, :binary
      add :content, :string
      add :upvotes, :integer
      add :downvotes, :integer
      add :forum_id, references(:forums, type: :binary_id, on_delete: :nothing)

      timestamps()
    end

    create index(:threads, [:forum_id])
  end
end
