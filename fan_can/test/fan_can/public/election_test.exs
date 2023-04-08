defmodule FanCan.Public.ElectionTest do
  use FanCan.DataCase

  alias FanCan.Public.Election

  describe "races" do
    alias FanCan.Public.Election.Race

    import FanCan.Public.ElectionFixtures

    @invalid_attrs %{attachments: nil, candidates: nil, district: nil, elect_percentage: nil, election_date: nil, seat: nil, state: nil, year: nil}

    test "list_races/0 returns all races" do
      race = race_fixture()
      assert Election.list_races() == [race]
    end

    test "get_race!/1 returns the race with given id" do
      race = race_fixture()
      assert Election.get_race!(race.id) == race
    end

    test "create_race/1 with valid data creates a race" do
      valid_attrs = %{attachments: [], candidates: [], district: 42, elect_percentage: 42, election_date: ~D[2023-04-06], seat: "some seat", state: "some state", year: 42}

      assert {:ok, %Race{} = race} = Election.create_race(valid_attrs)
      assert race.attachments == []
      assert race.candidates == []
      assert race.district == 42
      assert race.elect_percentage == 42
      assert race.election_date == ~D[2023-04-06]
      assert race.seat == "some seat"
      assert race.state == "some state"
      assert race.year == 42
    end

    test "create_race/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Election.create_race(@invalid_attrs)
    end

    test "update_race/2 with valid data updates the race" do
      race = race_fixture()
      update_attrs = %{attachments: [], candidates: [], district: 43, elect_percentage: 43, election_date: ~D[2023-04-07], seat: "some updated seat", state: "some updated state", year: 43}

      assert {:ok, %Race{} = race} = Election.update_race(race, update_attrs)
      assert race.attachments == []
      assert race.candidates == []
      assert race.district == 43
      assert race.elect_percentage == 43
      assert race.election_date == ~D[2023-04-07]
      assert race.seat == "some updated seat"
      assert race.state == "some updated state"
      assert race.year == 43
    end

    test "update_race/2 with invalid data returns error changeset" do
      race = race_fixture()
      assert {:error, %Ecto.Changeset{}} = Election.update_race(race, @invalid_attrs)
      assert race == Election.get_race!(race.id)
    end

    test "delete_race/1 deletes the race" do
      race = race_fixture()
      assert {:ok, %Race{}} = Election.delete_race(race)
      assert_raise Ecto.NoResultsError, fn -> Election.get_race!(race.id) end
    end

    test "change_race/1 returns a race changeset" do
      race = race_fixture()
      assert %Ecto.Changeset{} = Election.change_race(race)
    end
  end
end
