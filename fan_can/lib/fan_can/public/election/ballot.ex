defmodule FanCan.Public.Election.Ballot do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "ballots" do
    field :attachment, :binary_id
    field :columns, :integer
    field :election_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(ballot, attrs) do
    ballot
    |> cast(attrs, [:id, :election_id, :columns, :attachment])
    |> validate_required([:election_id])
  end
end
