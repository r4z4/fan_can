defmodule FanCan.Repo.Migrations.CreateUserHolds do
  use Ecto.Migration

  def change do
    create table(:user_holds, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id_init, references(:users, type: :binary_id, on_delete: :delete_all), null: false
      add :type, :string, null: false
      add :user_id_recv, references(:users, type: :binary_id, on_delete: :delete_all), null: false

      timestamps()
    end
    create unique_index(:user_holds, [:user_id_init, :type, :user_id_recv])
  end
end
