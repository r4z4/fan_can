defmodule FanCan.Repo.Migrations.CreateCandidateHolds do
  use Ecto.Migration

  def change do
    create table(:candidate_holds, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all), null: false
      add :type, :string, null: false
      add :candidate_id, references(:candidates, type: :binary_id, on_delete: :delete_all), null: false

      timestamps()
    end
    create unique_index(:candidate_holds, [:user_id, :type, :candidate_id])
  end
end
