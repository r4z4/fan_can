defmodule FanCan.Repo.Migrations.CreateBallots do
  use Ecto.Migration

  def change do
    create table(:ballots, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :columns, :integer
      add :attachment, references(:attachments, type: :binary_id, on_delete: :nothing)
      add :election, references(:elections, type: :binary_id, on_delete: :nothing)

      timestamps()
    end

    create index(:ballots, [:election])
  end
end
