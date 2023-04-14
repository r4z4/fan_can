defmodule FanCan.Site.Forum do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "forums" do
    field :category, Ecto.Enum, values: Utils.forum_categories
    field :members, {:array, :binary_id}
    field :desc, :string
    field :title, :string
    field :moderator, :binary_id

    timestamps()
  end

  @doc false
  def changeset(forum, attrs) do
    forum
    |> cast(attrs, [:title, :category, :members. :moderator, :desc])
    |> validate_required([:title, :category])
  end
end
