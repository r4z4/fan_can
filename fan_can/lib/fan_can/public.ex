defmodule FanCan.Public do
  @moduledoc """
  The Public context.
  """

  import Ecto.Query, warn: false
  alias FanCan.Repo

  alias FanCan.Public.Candidate

  @doc """
  Returns the list of candidates.

  ## Examples

      iex> list_candidates()
      [%Candidate{}, ...]

  """
  def list_candidates do
    Repo.all(Candidate)
  end

  @doc """
  Gets a single candidate.

  Raises `Ecto.NoResultsError` if the Candidate does not exist.

  ## Examples

      iex> get_candidate!(123)
      %Candidate{}

      iex> get_candidate!(456)
      ** (Ecto.NoResultsError)

  """
  def get_candidate!(id), do: Repo.get!(Candidate, id)

  @doc """
  Creates a candidate.

  ## Examples

      iex> create_candidate(%{field: value})
      {:ok, %Candidate{}}

      iex> create_candidate(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_candidate(attrs \\ %{}) do
    %Candidate{}
    |> Candidate.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a candidate.

  ## Examples

      iex> update_candidate(candidate, %{field: new_value})
      {:ok, %Candidate{}}

      iex> update_candidate(candidate, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_candidate(%Candidate{} = candidate, attrs) do
    candidate
    |> Candidate.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a candidate.

  ## Examples

      iex> delete_candidate(candidate)
      {:ok, %Candidate{}}

      iex> delete_candidate(candidate)
      {:error, %Ecto.Changeset{}}

  """
  def delete_candidate(%Candidate{} = candidate) do
    Repo.delete(candidate)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking candidate changes.

  ## Examples

      iex> change_candidate(candidate)
      %Ecto.Changeset{data: %Candidate{}}

  """
  def change_candidate(%Candidate{} = candidate, attrs \\ %{}) do
    Candidate.changeset(candidate, attrs)
  end

  alias FanCan.Public.Election

  @doc """
  Returns the list of elections.

  ## Examples

      iex> list_elections()
      [%Election{}, ...]

  """
  def list_elections do
    Repo.all(Election)
  end

  @doc """
  Gets a single election.

  Raises `Ecto.NoResultsError` if the Election does not exist.

  ## Examples

      iex> get_election!(123)
      %Election{}

      iex> get_election!(456)
      ** (Ecto.NoResultsError)

  """
  def get_election!(id), do: Repo.get!(Election, id)

  @doc """
  Creates a election.

  ## Examples

      iex> create_election(%{field: value})
      {:ok, %Election{}}

      iex> create_election(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_election(attrs \\ %{}) do
    %Election{}
    |> Election.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a election.

  ## Examples

      iex> update_election(election, %{field: new_value})
      {:ok, %Election{}}

      iex> update_election(election, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_election(%Election{} = election, attrs) do
    election
    |> Election.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a election.

  ## Examples

      iex> delete_election(election)
      {:ok, %Election{}}

      iex> delete_election(election)
      {:error, %Ecto.Changeset{}}

  """
  def delete_election(%Election{} = election) do
    Repo.delete(election)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking election changes.

  ## Examples

      iex> change_election(election)
      %Ecto.Changeset{data: %Election{}}

  """
  def change_election(%Election{} = election, attrs \\ %{}) do
    Election.changeset(election, attrs)
  end
end