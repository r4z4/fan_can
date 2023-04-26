defmodule FanCan.Site.Forum.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "posts" do
    field :author, :binary_id
    field :content, :string
    field :likes, :integer
    field :shares, :integer
    field :title, :string
    field :thread, :binary_id

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :author, :content, :likes, :shares])
    |> validate_required([:title, :author, :content])
  end
end
