defmodule FanCan.Repo.Migrations.CreateElectionHolds do
  use Ecto.Migration

  def change do
    create table(:election_holds, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all), null: false
      add :type, :string, null: false
      add :election_id, references(:elections, type: :binary_id, on_delete: :delete_all), null: false

      timestamps()
    end
    create unique_index(:election_holds, [:user_id, :type, :election_id])
  end
end
