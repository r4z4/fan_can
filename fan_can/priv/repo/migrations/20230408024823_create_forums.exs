defmodule FanCan.Repo.Migrations.CreateForums do
  use Ecto.Migration

  def change do
    create table(:forums) do
      add :title, :string
      add :category, :string
      add :subscribers, {:array, :binary_id}
      add :moderator, references(:users, type: :binary_id, on_delete: :nothing)

      timestamps()
    end

    create index(:forums, [:moderator])
  end
end
