defmodule FanCan.PublicTest do
  use FanCan.DataCase

  alias FanCan.Public

  describe "candidates" do
    alias FanCan.Public.Candidate

    import FanCan.PublicFixtures

    @invalid_attrs %{attachments: nil, cpvi: nil, district: nil, dob: nil, f_name: nil, incumbent_since: nil, l_name: nil, party: nil, prefix: nil, residence: nil, state: nil, suffix: nil, type: nil}

    test "list_candidates/0 returns all candidates" do
      candidate = candidate_fixture()
      assert Public.list_candidates() == [candidate]
    end

    test "get_candidate!/1 returns the candidate with given id" do
      candidate = candidate_fixture()
      assert Public.get_candidate!(candidate.id) == candidate
    end

    test "create_candidate/1 with valid data creates a candidate" do
      valid_attrs = %{attachments: [], cpvi: "some cpvi", district: 42, dob: ~D[2023-04-06], f_name: "some f_name", incumbent_since: ~D[2023-04-06], l_name: "some l_name", party: :republican, prefix: "some prefix", residence: "some residence", state: "some state", suffix: "some suffix", type: "some type"}

      assert {:ok, %Candidate{} = candidate} = Public.create_candidate(valid_attrs)
      assert candidate.attachments == []
      assert candidate.cpvi == "some cpvi"
      assert candidate.district == 42
      assert candidate.dob == ~D[2023-04-06]
      assert candidate.f_name == "some f_name"
      assert candidate.incumbent_since == ~D[2023-04-06]
      assert candidate.l_name == "some l_name"
      assert candidate.party == :republican
      assert candidate.prefix == "some prefix"
      assert candidate.residence == "some residence"
      assert candidate.state == "some state"
      assert candidate.suffix == "some suffix"
      assert candidate.type == "some type"
    end

    test "create_candidate/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Public.create_candidate(@invalid_attrs)
    end

    test "update_candidate/2 with valid data updates the candidate" do
      candidate = candidate_fixture()
      update_attrs = %{attachments: [], cpvi: "some updated cpvi", district: 43, dob: ~D[2023-04-07], f_name: "some updated f_name", incumbent_since: ~D[2023-04-07], l_name: "some updated l_name", party: :democrat, prefix: "some updated prefix", residence: "some updated residence", state: "some updated state", suffix: "some updated suffix", type: "some updated type"}

      assert {:ok, %Candidate{} = candidate} = Public.update_candidate(candidate, update_attrs)
      assert candidate.attachments == []
      assert candidate.cpvi == "some updated cpvi"
      assert candidate.district == 43
      assert candidate.dob == ~D[2023-04-07]
      assert candidate.f_name == "some updated f_name"
      assert candidate.incumbent_since == ~D[2023-04-07]
      assert candidate.l_name == "some updated l_name"
      assert candidate.party == :democrat
      assert candidate.prefix == "some updated prefix"
      assert candidate.residence == "some updated residence"
      assert candidate.state == "some updated state"
      assert candidate.suffix == "some updated suffix"
      assert candidate.type == "some updated type"
    end

    test "update_candidate/2 with invalid data returns error changeset" do
      candidate = candidate_fixture()
      assert {:error, %Ecto.Changeset{}} = Public.update_candidate(candidate, @invalid_attrs)
      assert candidate == Public.get_candidate!(candidate.id)
    end

    test "delete_candidate/1 deletes the candidate" do
      candidate = candidate_fixture()
      assert {:ok, %Candidate{}} = Public.delete_candidate(candidate)
      assert_raise Ecto.NoResultsError, fn -> Public.get_candidate!(candidate.id) end
    end

    test "change_candidate/1 returns a candidate changeset" do
      candidate = candidate_fixture()
      assert %Ecto.Changeset{} = Public.change_candidate(candidate)
    end
  end

  describe "elections" do
    alias FanCan.Public.Election

    import FanCan.PublicFixtures

    @invalid_attrs %{desc: nil, election_date: nil, state: nil, year: nil}

    test "list_elections/0 returns all elections" do
      election = election_fixture()
      assert Public.list_elections() == [election]
    end

    test "get_election!/1 returns the election with given id" do
      election = election_fixture()
      assert Public.get_election!(election.id) == election
    end

    test "create_election/1 with valid data creates a election" do
      valid_attrs = %{desc: "some desc", election_date: ~D[2023-04-06], state: "some state", year: 42}

      assert {:ok, %Election{} = election} = Public.create_election(valid_attrs)
      assert election.desc == "some desc"
      assert election.election_date == ~D[2023-04-06]
      assert election.state == "some state"
      assert election.year == 42
    end

    test "create_election/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Public.create_election(@invalid_attrs)
    end

    test "update_election/2 with valid data updates the election" do
      election = election_fixture()
      update_attrs = %{desc: "some updated desc", election_date: ~D[2023-04-07], state: "some updated state", year: 43}

      assert {:ok, %Election{} = election} = Public.update_election(election, update_attrs)
      assert election.desc == "some updated desc"
      assert election.election_date == ~D[2023-04-07]
      assert election.state == "some updated state"
      assert election.year == 43
    end

    test "update_election/2 with invalid data returns error changeset" do
      election = election_fixture()
      assert {:error, %Ecto.Changeset{}} = Public.update_election(election, @invalid_attrs)
      assert election == Public.get_election!(election.id)
    end

    test "delete_election/1 deletes the election" do
      election = election_fixture()
      assert {:ok, %Election{}} = Public.delete_election(election)
      assert_raise Ecto.NoResultsError, fn -> Public.get_election!(election.id) end
    end

    test "change_election/1 returns a election changeset" do
      election = election_fixture()
      assert %Ecto.Changeset{} = Public.change_election(election)
    end
  end

  describe "states" do
    alias FanCan.Public.State

    import FanCan.PublicFixtures

    @invalid_attrs %{capital_city: nil, code: nil, id: nil, name: nil, num_districts: nil, population: nil}

    test "list_states/0 returns all states" do
      state = state_fixture()
      assert Public.list_states() == [state]
    end

    test "get_state!/1 returns the state with given id" do
      state = state_fixture()
      assert Public.get_state!(state.id) == state
    end

    test "create_state/1 with valid data creates a state" do
      valid_attrs = %{capital_city: "some capital_city", code: "some code", id: 42, name: "some name", num_districts: 42, population: 42}

      assert {:ok, %State{} = state} = Public.create_state(valid_attrs)
      assert state.capital_city == "some capital_city"
      assert state.code == "some code"
      assert state.id == 42
      assert state.name == "some name"
      assert state.num_districts == 42
      assert state.population == 42
    end

    test "create_state/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Public.create_state(@invalid_attrs)
    end

    test "update_state/2 with valid data updates the state" do
      state = state_fixture()
      update_attrs = %{capital_city: "some updated capital_city", code: "some updated code", id: 43, name: "some updated name", num_districts: 43, population: 43}

      assert {:ok, %State{} = state} = Public.update_state(state, update_attrs)
      assert state.capital_city == "some updated capital_city"
      assert state.code == "some updated code"
      assert state.id == 43
      assert state.name == "some updated name"
      assert state.num_districts == 43
      assert state.population == 43
    end

    test "update_state/2 with invalid data returns error changeset" do
      state = state_fixture()
      assert {:error, %Ecto.Changeset{}} = Public.update_state(state, @invalid_attrs)
      assert state == Public.get_state!(state.id)
    end

    test "delete_state/1 deletes the state" do
      state = state_fixture()
      assert {:ok, %State{}} = Public.delete_state(state)
      assert_raise Ecto.NoResultsError, fn -> Public.get_state!(state.id) end
    end

    test "change_state/1 returns a state changeset" do
      state = state_fixture()
      assert %Ecto.Changeset{} = Public.change_state(state)
    end
  end
end
