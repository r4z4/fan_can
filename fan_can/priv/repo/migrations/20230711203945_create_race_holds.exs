defmodule FanCan.Repo.Migrations.CreateRaceHolds do
  use Ecto.Migration

  def change do
    create table(:race_holds, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all), null: false
      add :type, :string, null: false
      add :race_id, references(:races, type: :binary_id, on_delete: :delete_all), null: false

      timestamps()
    end
    create unique_index(:race_holds, [:user_id, :type, :race_id], name: :race_holds_u_index)
  end
end
