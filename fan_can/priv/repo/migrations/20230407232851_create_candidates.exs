defmodule FanCan.Repo.Migrations.CreateCandidates do
  use Ecto.Migration

  def change do
    create table(:candidates, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :prefix, :string
      add :f_name, :string
      add :l_name, :string
      add :suffix, :string
      add :state, :string
      add :district, :integer
      add :residence, :string
      add :type, :string
      add :party, :string
      add :cpvi, :string
      add :incumbent_since, :date
      add :dob, :date
      add :attachments, {:array, :binary_id}

      timestamps()
    end
  end
end
