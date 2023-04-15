defmodule FanCan.Public.Election do
  use Ecto.Schema
  import Ecto.Changeset
  alias FanCan.Core.Utils
  
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "elections" do
    field :desc, :string
    field :election_date, :date
    field :state, Ecto.Enum, values: Utils.states
    field :year, :integer

    timestamps()
  end

  @doc false
  def changeset(election, attrs) do
    election
    |> cast(attrs, [:year, :state, :desc, :election_date])
    |> validate_required([:year, :state, :desc, :election_date])
  end

  alias FanCan.Public.Election.Race
  alias FanCan.Public.Election.Ballot
  alias FanCan.Public.Election.BallotRace
  alias FanCan.Public.Election  
  alias FanCan.Public.Candidate  
  import Ecto.Query, warn: false
  alias FanCan.Repo

  @type ballot_map :: %{
   id: binary,
   candidates: [binary],
   year: integer,
   election_date: %Date{},
   desc: String.t,
   seat: atom,
   state: atom,
   inserted_at: %NaiveDateTime{},
   updated_at: %NaiveDateTime{},
}

  @spec get_ballot_races(binary) :: [ballot_map]
  def get_ballot_races(ballot_id) do
    query = from r in Race,
      join: c in Candidate,
      on: c.id in r.candidates,
      join: e in Election,
      on: r.election_id == e.id,
      join: b in Ballot,
      on: b.election == e.id,
      where: b.id == ^ballot_id,
      # FIXME Change this to confirmed_at > inserted_at
      # Or can do "id" => r.id, "candidates" => .... then access via ballot_race["id"] in template.
      select: %{:id => r.id, :candidates => [{c}], :seat => r.seat, :state => e.state, :desc => e.desc, :election_date => e.election_date, :year => e.year, :inserted_at => b.inserted_at, :updated_at => b.updated_at}
      # select: {u.username, u.email, u.inserted_at, us.easy_games_played, us.easy_games_finished, us.med_games_played, us.med_games_finished, us.hard_games_played, us.hard_games_finished, 
      #           us.easy_poss_pts, us.easy_earned_pts, us.med_poss_pts, us.med_earned_pts, us.hard_poss_pts, us.hard_earned_pts}
      # distinct: p.id
      # where: u.age > type(^age, :integer)
    FanCan.Repo.all(query)
  end

  @doc """
  Returns the list of races.

  ## Examples

      iex> list_races()
      [%Race{}, ...]

  """
  def list_races do
    Repo.all(Race)
  end

  @doc """
  Gets a single race.

  Raises `Ecto.NoResultsError` if the Race does not exist.

  ## Examples

      iex> get_race!(123)
      %Race{}

      iex> get_race!(456)
      ** (Ecto.NoResultsError)

  """
  def get_race!(id), do: Repo.get!(Race, id)

  @doc """
  Creates a race.

  ## Examples

      iex> create_race(%{field: value})
      {:ok, %Race{}}

      iex> create_race(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_race(attrs \\ %{}) do
    %Race{}
    |> Race.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a race.

  ## Examples

      iex> update_race(race, %{field: new_value})
      {:ok, %Race{}}

      iex> update_race(race, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_race(%Race{} = race, attrs) do
    race
    |> Race.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a race.

  ## Examples

      iex> delete_race(race)
      {:ok, %Race{}}

      iex> delete_race(race)
      {:error, %Ecto.Changeset{}}

  """
  def delete_race(%Race{} = race) do
    Repo.delete(race)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking race changes.

  ## Examples

      iex> change_race(race)
      %Ecto.Changeset{data: %Race{}}

  """
  def change_race(%Race{} = race, attrs \\ %{}) do
    Race.changeset(race, attrs)
  end

  alias FanCan.Public.Election.Ballot

  @doc """
  Returns the list of ballots.

  ## Examples

      iex> list_ballots()
      [%Ballot{}, ...]

  """
  def list_ballots do
    Repo.all(Ballot)
  end

  @doc """
  Gets a single ballot.

  Raises `Ecto.NoResultsError` if the Ballot does not exist.

  ## Examples

      iex> get_ballot!(123)
      %Ballot{}

      iex> get_ballot!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ballot!(id), do: Repo.get!(Ballot, id)

  @doc """
  Creates a ballot.

  ## Examples

      iex> create_ballot(%{field: value})
      {:ok, %Ballot{}}

      iex> create_ballot(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ballot(attrs \\ %{}) do
    %Ballot{}
    |> Ballot.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ballot.

  ## Examples

      iex> update_ballot(ballot, %{field: new_value})
      {:ok, %Ballot{}}

      iex> update_ballot(ballot, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ballot(%Ballot{} = ballot, attrs) do
    ballot
    |> Ballot.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ballot.

  ## Examples

      iex> delete_ballot(ballot)
      {:ok, %Ballot{}}

      iex> delete_ballot(ballot)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ballot(%Ballot{} = ballot) do
    Repo.delete(ballot)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ballot changes.

  ## Examples

      iex> change_ballot(ballot)
      %Ecto.Changeset{data: %Ballot{}}

  """
  def change_ballot(%Ballot{} = ballot, attrs \\ %{}) do
    Ballot.changeset(ballot, attrs)
  end
end
