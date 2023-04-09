defmodule FanCan.Public.State do
  use Ecto.Schema
  import Ecto.Changeset
  alias FanCan.Core.Utils

  @primary_key {:id, :integer, autogenerate: false}
  @foreign_key_type :integer
  schema "states" do
    field :code, Ecto.Enum, values: Utils.states
    field :name, Ecto.Enum, values: Utils.state_names
    field :num_districts, :integer
    field :population, :integer
    field :governor, :binary_id

    timestamps()
  end

  @doc false
  def changeset(state, attrs) do
    state
    |> cast(attrs, [:id, :name, :code, :population, :num_districts, :capital_city])
    |> validate_required([:id, :name, :code, :population, :num_districts, :capital_city])
  end
end
