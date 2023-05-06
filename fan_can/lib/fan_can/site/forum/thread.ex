defmodule FanCan.Site.Forum.Thread do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "threads" do
    field :content, :string
    field :creator, :binary_id
    field :likes, :integer
    field :title, :string
    field :shares, :integer
    field :forum_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(thread, attrs) do
    thread
    |> cast(attrs, [:title, :creator, :content, :likes, :shares])
    |> validate_required([:title, :creator, :content, :likes, :shares])
  end
end
