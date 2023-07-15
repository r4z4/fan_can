defmodule FanCan.Public.Election.CandidateHolds do
  use Ecto.Schema
  import Ecto.Changeset
  alias FanCan.Core.Utils
  
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "candidate_holds" do
    field :user_id, :binary_id
    field :candidate_id, :binary_id
    field :type, Ecto.Enum, values: Utils.hold_types

    timestamps()
  end

  @doc false
  def changeset(candidate_holds, attrs) do
    candidate_holds
    |> cast(attrs, [:id, :user_id, :type, :candidate_id])
    |> validate_required([:id, :user_id, :type, :candidate_id])
    |> unique_constraint(:id)
  end
end
