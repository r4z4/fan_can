defmodule FanCan.Accounts.UserFollows do
  use Ecto.Schema
  import Ecto.Changeset
  alias FanCan.Core.Utils
  
  @primary_key {:user_id, :binary_id, autogenerate: false}
  @foreign_key_type :binary_id
  schema "user_follows" do
    field :follow_ids, {:array, :binary_id}
    field :type, Ecto.Enum, values: Utils.follows_types

    timestamps()
  end

  @doc false
  def changeset(user_follows, attrs) do
    user_follows
    |> cast(attrs, [:user_id, :type, :follow_ids])
    |> validate_required([:user_id, :type, :follow_ids])
  end
end
