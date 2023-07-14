defmodule FanCan.Repo.Migrations.CreateUserFollows do
  use Ecto.Migration

  def change do
    create table(:user_follows, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all), null: false
      add :type, :string, null: false
      add :follow_ids, {:array, :binary_id}

      timestamps()
    end
    create unique_index(:user_follows, [:user_id, :type])
  end
end
