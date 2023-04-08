defmodule FanCan.Core.Attachments do
  use Ecto.Schema
  import Ecto.Changeset
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "attachments" do
    field :data, :binary
    field :path, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(attachments, attrs) do
    attachments
    |> cast(attrs, [:title, :path, :data])
    |> validate_required([:title, :path, :data])
  end
end
