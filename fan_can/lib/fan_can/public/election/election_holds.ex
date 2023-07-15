defmodule FanCan.Public.Election.ElectionHolds do
  use Ecto.Schema
  import Ecto.Changeset
  alias FanCan.Core.Utils
  
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "election_holds" do
    field :user_id, :binary_id
    field :election_id, :binary_id
    field :type, Ecto.Enum, values: Utils.hold_types

    timestamps()
  end

  @doc false
  def changeset(election_holds, attrs) do
    election_holds
    |> cast(attrs, [:id, :user_id, :type, :election_id])
    |> validate_required([:id, :user_id, :type, :election_id])
    |> unique_constraint(:id)
  end
end
