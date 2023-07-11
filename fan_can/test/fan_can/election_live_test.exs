defmodule FanCanWeb.ElectionLiveTest do
  use FanCanWeb.ConnCase
  use ExUnit.Case
  use PropCheck

  import Phoenix.LiveViewTest
  import FanCan.PublicFixtures

  @create_attrs %{desc: "some desc", election_date: "2023-04-06", state: :MN, year: 42}
  @update_attrs %{desc: "some updated desc", election_date: "2023-04-07", state: :MN, year: 43}
  @invalid_attrs %{desc: nil, election_date: nil, state: nil, year: nil}

  defp create_election(_) do
    election = election_fixture()
    %{election: election}
  end

  describe "Index" do

    property "Elections should be elections", [:verbose] do
      forall election <- create_election("hey") do
        assert election.election.year == 42
      end
    end
  end

end
