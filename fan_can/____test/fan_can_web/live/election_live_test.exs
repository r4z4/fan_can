defmodule FanCanWeb.ElectionLiveTest do
  use FanCanWeb.ConnCase

  import Phoenix.LiveViewTest
  import FanCan.PublicFixtures

  @create_attrs %{desc: "some desc", election_date: "2023-04-06", state: "some state", year: 42}
  @update_attrs %{desc: "some updated desc", election_date: "2023-04-07", state: "some updated state", year: 43}
  @invalid_attrs %{desc: nil, election_date: nil, state: nil, year: nil}

  defp create_election(_) do
    election = election_fixture()
    %{election: election}
  end

  describe "Index" do
    setup [:create_election]

    test "lists all elections", %{conn: conn, election: election} do
      {:ok, _index_live, html} = live(conn, ~p"/elections")

      assert html =~ "Listing Elections"
      assert html =~ election.desc
    end

    test "saves new election", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/elections")

      assert index_live |> element("a", "New Election") |> render_click() =~
               "New Election"

      assert_patch(index_live, ~p"/elections/new")

      assert index_live
             |> form("#election-form", election: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#election-form", election: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/elections")

      html = render(index_live)
      assert html =~ "Election created successfully"
      assert html =~ "some desc"
    end

    test "updates election in listing", %{conn: conn, election: election} do
      {:ok, index_live, _html} = live(conn, ~p"/elections")

      assert index_live |> element("#elections-#{election.id} a", "Edit") |> render_click() =~
               "Edit Election"

      assert_patch(index_live, ~p"/elections/#{election}/edit")

      assert index_live
             |> form("#election-form", election: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#election-form", election: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/elections")

      html = render(index_live)
      assert html =~ "Election updated successfully"
      assert html =~ "some updated desc"
    end

    test "deletes election in listing", %{conn: conn, election: election} do
      {:ok, index_live, _html} = live(conn, ~p"/elections")

      assert index_live |> element("#elections-#{election.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#elections-#{election.id}")
    end
  end

  describe "Show" do
    setup [:create_election]

    test "displays election", %{conn: conn, election: election} do
      {:ok, _show_live, html} = live(conn, ~p"/elections/#{election}")

      assert html =~ "Show Election"
      assert html =~ election.desc
    end

    test "updates election within modal", %{conn: conn, election: election} do
      {:ok, show_live, _html} = live(conn, ~p"/elections/#{election}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Election"

      assert_patch(show_live, ~p"/elections/#{election}/show/edit")

      assert show_live
             |> form("#election-form", election: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#election-form", election: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/elections/#{election}")

      html = render(show_live)
      assert html =~ "Election updated successfully"
      assert html =~ "some updated desc"
    end
  end
end
