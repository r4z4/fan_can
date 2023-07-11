defmodule FanCan.PublicFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FanCan.Public` context.
  """

  @doc """
  Generate a candidate.
  """
  def candidate_fixture(attrs \\ %{}) do
    {:ok, candidate} =
      attrs
      |> Enum.into(%{
        attachments: [],
        cpvi: "some cpvi",
        district: 42,
        dob: ~D[2023-04-06],
        f_name: "some f_name",
        incumbent_since: ~D[2023-04-06],
        l_name: "some l_name",
        party: :republican,
        prefix: "some prefix",
        residence: "some residence",
        state: :MN,
        suffix: "some suffix",
        type: "some type"
      })
      |> FanCan.Public.create_candidate()

    candidate
  end

  @doc """
  Generate a election.
  """
  def election_fixture(attrs \\ %{}) do
    {:ok, election} =
      attrs
      |> Enum.into(%{
        desc: "some desc",
        election_date: ~D[2023-04-06],
        state: :MN,
        year: 42
      })
      |> FanCan.Public.create_election()

    election
  end

  @doc """
  Generate a state.
  """
  def state_fixture(attrs \\ %{}) do
    {:ok, state} =
      attrs
      |> Enum.into(%{
        capital_city: "some capital_city",
        code: "some code",
        id: 42,
        name: "some name",
        num_districts: 42,
        population: 42
      })
      |> FanCan.Public.create_state()

    state
  end
end
