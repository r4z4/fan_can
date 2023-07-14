defmodule FanCan.Accounts.UserFollows do
  use Ecto.Schema
  import Ecto.Changeset
  alias FanCan.Core.Utils
  
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "user_follows" do
    field :user_id, :binary_id
    field :follow_ids, {:array, :binary_id}
    field :type, Ecto.Enum, values: Utils.follows_types

    timestamps()
  end

  @doc false
  def changeset(user_follows, attrs) do
    user_follows
    |> cast(attrs, [:id, :user_id, :type, :follow_ids])
    |> validate_required([:id, :user_id, :type, :follow_ids])
    |> unique_constraint(:id)
  end
end
