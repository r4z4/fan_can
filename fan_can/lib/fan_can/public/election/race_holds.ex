defmodule FanCan.Public.Election.RaceHolds do
  use Ecto.Schema
  import Ecto.Changeset
  alias FanCan.Core.Utils
  
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "race_holds" do
    field :user_id, :binary_id
    field :race_id, :binary_id
    field :type, Ecto.Enum, values: Utils.hold_types

    timestamps()
  end

  @doc false
  def changeset(race_holds, attrs) do
    race_holds
    |> cast(attrs, [:id, :user_id, :type, :race_id])
    |> validate_required([:id, :user_id, :type, :race_id])
    |> unique_constraint(:race_holds_schema_constraint, name: :race_holds_u_index)
    |> unique_constraint(:id)
  end
end
