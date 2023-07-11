defmodule FanCanWeb.BallotLiveTest do
  use FanCanWeb.ConnCase

  import Phoenix.LiveViewTest
  import FanCan.Public.ElectionFixtures

  @create_attrs %{attachment: "some attachment", columns: 42, races: [], state: "some state", year: 42}
  @update_attrs %{attachment: "some updated attachment", columns: 43, races: [], state: "some updated state", year: 43}
  @invalid_attrs %{attachment: nil, columns: nil, races: [], state: nil, year: nil}

  defp create_ballot(_) do
    ballot = ballot_fixture()
    %{ballot: ballot}
  end

  describe "Index" do
    setup [:create_ballot]

    test "lists all ballots", %{conn: conn, ballot: ballot} do
      {:ok, _index_live, html} = live(conn, ~p"/ballots")

      assert html =~ "Listing Ballots"
      assert html =~ ballot.state
    end

    test "saves new ballot", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/ballots")

      assert index_live |> element("a", "New Ballot") |> render_click() =~
               "New Ballot"

      assert_patch(index_live, ~p"/ballots/new")

      assert index_live
             |> form("#ballot-form", ballot: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#ballot-form", ballot: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/ballots")

      html = render(index_live)
      assert html =~ "Ballot created successfully"
      assert html =~ "some state"
    end

    test "updates ballot in listing", %{conn: conn, ballot: ballot} do
      {:ok, index_live, _html} = live(conn, ~p"/ballots")

      assert index_live |> element("#ballots-#{ballot.id} a", "Edit") |> render_click() =~
               "Edit Ballot"

      assert_patch(index_live, ~p"/ballots/#{ballot}/edit")

      assert index_live
             |> form("#ballot-form", ballot: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#ballot-form", ballot: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/ballots")

      html = render(index_live)
      assert html =~ "Ballot updated successfully"
      assert html =~ "some updated state"
    end

    test "deletes ballot in listing", %{conn: conn, ballot: ballot} do
      {:ok, index_live, _html} = live(conn, ~p"/ballots")

      assert index_live |> element("#ballots-#{ballot.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#ballots-#{ballot.id}")
    end
  end

  describe "Show" do
    setup [:create_ballot]

    test "displays ballot", %{conn: conn, ballot: ballot} do
      {:ok, _show_live, html} = live(conn, ~p"/ballots/#{ballot}")

      assert html =~ "Show Ballot"
      assert html =~ ballot.state
    end

    test "updates ballot within modal", %{conn: conn, ballot: ballot} do
      {:ok, show_live, _html} = live(conn, ~p"/ballots/#{ballot}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Ballot"

      assert_patch(show_live, ~p"/ballots/#{ballot}/show/edit")

      assert show_live
             |> form("#ballot-form", ballot: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#ballot-form", ballot: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/ballots/#{ballot}")

      html = render(show_live)
      assert html =~ "Ballot updated successfully"
      assert html =~ "some updated state"
    end
  end
end
