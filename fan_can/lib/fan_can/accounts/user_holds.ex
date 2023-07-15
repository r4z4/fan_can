defmodule FanCan.Accounts.UserHolds do
  use Ecto.Schema
  import Ecto.Changeset
  alias FanCan.Core.Utils
  
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "user_holds" do
    field :user_id_init, :binary_id
    field :user_id_recv, :binary_id
    field :type, Ecto.Enum, values: Utils.hold_types

    timestamps()
  end

  @doc false
  def changeset(user_holds, attrs) do
    user_holds
    |> cast(attrs, [:id, :user_id_init, :type, :user_id_recv])
    |> validate_required([:id, :user_id_init, :type, :user_id_recv])
    |> unique_constraint(:id)
  end
end
