defmodule FanCan.Site.Forum.Thread do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "threads" do
    field :content, :string
    field :creator, :binary_id
    field :downvotes, :integer
    field :title, :string
    field :upvotes, :integer
    field :forum_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(thread, attrs) do
    thread
    |> cast(attrs, [:title, :creator, :content, :upvotes, :downvotes])
    |> validate_required([:title, :creator, :content, :upvotes, :downvotes])
  end
end
