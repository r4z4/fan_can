defmodule FanCan.Public.ElectionFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FanCan.Public.Election` context.
  """

  @doc """
  Generate a race.
  """
  def race_fixture(attrs \\ %{}) do
    {:ok, race} =
      attrs
      |> Enum.into(%{
        attachments: [],
        candidates: [],
        district: 42,
        elect_percentage: 42,
        election_date: ~D[2023-04-06],
        seat: "some seat",
        state: "some state",
        year: 42
      })
      |> FanCan.Public.Election.create_race()

    race
  end

  @doc """
  Generate a ballot.
  """
  def ballot_fixture(attrs \\ %{}) do
    {:ok, ballot} =
      attrs
      |> Enum.into(%{
        attachment: "some attachment",
        columns: 42,
        races: [],
        state: "some state",
        year: 42
      })
      |> FanCan.Public.Election.create_ballot()

    ballot
  end
end
