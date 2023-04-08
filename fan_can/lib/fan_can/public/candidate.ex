defmodule FanCan.Public.Candidate do
  use Ecto.Schema
  import Ecto.Changeset
  alias FanCan.Core.Utils
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "candidates" do
    field :attachments, {:array, :binary_id}
    field :cpvi, :string
    field :district, :integer
    field :dob, :date
    field :f_name, :string
    field :incumbent_since, :date
    field :l_name, :string
    field :party, Ecto.Enum, values: [:republican, :democrat, :independent, :other]
    field :prefix, :string
    field :residence, :string
    field :state, Ecto.Enum, values: Utils.states
    field :suffix, :string
    field :seat, Ecto.Enum, values: Utils.seats

    timestamps()
  end

  @doc false
  def changeset(candidate, attrs) do
    candidate
    |> cast(attrs, [:prefix, :f_name, :l_name, :suffix, :state, :district, :residence, :type, :party, :cpvi, :incumbent_since, :dob, :attachments])
    |> validate_required([:prefix, :f_name, :l_name, :suffix, :state, :district, :residence, :type, :party, :cpvi, :incumbent_since, :dob, :attachments])
  end
end
