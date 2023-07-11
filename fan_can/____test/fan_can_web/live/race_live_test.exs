defmodule FanCanWeb.RaceLiveTest do
  use FanCanWeb.ConnCase

  import Phoenix.LiveViewTest
  import FanCan.Public.ElectionFixtures

  @create_attrs %{attachments: [], candidates: [], district: 42, elect_percentage: 42, election_date: "2023-04-06", seat: "some seat", state: "some state", year: 42}
  @update_attrs %{attachments: [], candidates: [], district: 43, elect_percentage: 43, election_date: "2023-04-07", seat: "some updated seat", state: "some updated state", year: 43}
  @invalid_attrs %{attachments: [], candidates: [], district: nil, elect_percentage: nil, election_date: nil, seat: nil, state: nil, year: nil}

  defp create_race(_) do
    race = race_fixture()
    %{race: race}
  end

  describe "Index" do
    setup [:create_race]

    test "lists all races", %{conn: conn, race: race} do
      {:ok, _index_live, html} = live(conn, ~p"/races")

      assert html =~ "Listing Races"
      assert html =~ race.seat
    end

    test "saves new race", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/races")

      assert index_live |> element("a", "New Race") |> render_click() =~
               "New Race"

      assert_patch(index_live, ~p"/races/new")

      assert index_live
             |> form("#race-form", race: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#race-form", race: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/races")

      html = render(index_live)
      assert html =~ "Race created successfully"
      assert html =~ "some seat"
    end

    test "updates race in listing", %{conn: conn, race: race} do
      {:ok, index_live, _html} = live(conn, ~p"/races")

      assert index_live |> element("#races-#{race.id} a", "Edit") |> render_click() =~
               "Edit Race"

      assert_patch(index_live, ~p"/races/#{race}/edit")

      assert index_live
             |> form("#race-form", race: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#race-form", race: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/races")

      html = render(index_live)
      assert html =~ "Race updated successfully"
      assert html =~ "some updated seat"
    end

    test "deletes race in listing", %{conn: conn, race: race} do
      {:ok, index_live, _html} = live(conn, ~p"/races")

      assert index_live |> element("#races-#{race.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#races-#{race.id}")
    end
  end

  describe "Show" do
    setup [:create_race]

    test "displays race", %{conn: conn, race: race} do
      {:ok, _show_live, html} = live(conn, ~p"/races/#{race}")

      assert html =~ "Show Race"
      assert html =~ race.seat
    end

    test "updates race within modal", %{conn: conn, race: race} do
      {:ok, show_live, _html} = live(conn, ~p"/races/#{race}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Race"

      assert_patch(show_live, ~p"/races/#{race}/show/edit")

      assert show_live
             |> form("#race-form", race: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#race-form", race: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/races/#{race}")

      html = render(show_live)
      assert html =~ "Race updated successfully"
      assert html =~ "some updated seat"
    end
  end
end
