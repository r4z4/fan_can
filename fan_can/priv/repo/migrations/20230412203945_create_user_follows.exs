defmodule FanCan.Repo.Migrations.CreateUserFollows do
  use Ecto.Migration

  def change do
    create table(:user_follows, primary_key: false) do
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all), null: false, primary_key: true
      add :type, :string, null: false, primary_key: true
      add :follow_ids, {:array, :binary_id}

      timestamps()
    end
    create unique_index(:user_follows, [:user_id, :type])
  end
end
