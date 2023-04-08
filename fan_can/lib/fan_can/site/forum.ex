defmodule FanCan.Site.Forum do
  use Ecto.Schema
  import Ecto.Changeset

  schema "forums" do
    field :category, :string
    field :subscribers, {:array, :binary_id}
    field :title, :string
    field :moderator, :id

    timestamps()
  end

  @doc false
  def changeset(forum, attrs) do
    forum
    |> cast(attrs, [:title, :category, :subscribers])
    |> validate_required([:title, :category, :subscribers])
  end
end
