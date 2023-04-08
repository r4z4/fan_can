defmodule FanCanWeb.CandidateLiveTest do
  use FanCanWeb.ConnCase

  import Phoenix.LiveViewTest
  import FanCan.PublicFixtures

  @create_attrs %{attachments: [], cpvi: "some cpvi", district: 42, dob: "2023-04-06", f_name: "some f_name", incumbent_since: "2023-04-06", l_name: "some l_name", party: :republican, prefix: "some prefix", residence: "some residence", state: "some state", suffix: "some suffix", type: "some type"}
  @update_attrs %{attachments: [], cpvi: "some updated cpvi", district: 43, dob: "2023-04-07", f_name: "some updated f_name", incumbent_since: "2023-04-07", l_name: "some updated l_name", party: :democrat, prefix: "some updated prefix", residence: "some updated residence", state: "some updated state", suffix: "some updated suffix", type: "some updated type"}
  @invalid_attrs %{attachments: [], cpvi: nil, district: nil, dob: nil, f_name: nil, incumbent_since: nil, l_name: nil, party: nil, prefix: nil, residence: nil, state: nil, suffix: nil, type: nil}

  defp create_candidate(_) do
    candidate = candidate_fixture()
    %{candidate: candidate}
  end

  describe "Index" do
    setup [:create_candidate]

    test "lists all candidates", %{conn: conn, candidate: candidate} do
      {:ok, _index_live, html} = live(conn, ~p"/candidates")

      assert html =~ "Listing Candidates"
      assert html =~ candidate.cpvi
    end

    test "saves new candidate", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/candidates")

      assert index_live |> element("a", "New Candidate") |> render_click() =~
               "New Candidate"

      assert_patch(index_live, ~p"/candidates/new")

      assert index_live
             |> form("#candidate-form", candidate: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#candidate-form", candidate: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/candidates")

      html = render(index_live)
      assert html =~ "Candidate created successfully"
      assert html =~ "some cpvi"
    end

    test "updates candidate in listing", %{conn: conn, candidate: candidate} do
      {:ok, index_live, _html} = live(conn, ~p"/candidates")

      assert index_live |> element("#candidates-#{candidate.id} a", "Edit") |> render_click() =~
               "Edit Candidate"

      assert_patch(index_live, ~p"/candidates/#{candidate}/edit")

      assert index_live
             |> form("#candidate-form", candidate: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#candidate-form", candidate: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/candidates")

      html = render(index_live)
      assert html =~ "Candidate updated successfully"
      assert html =~ "some updated cpvi"
    end

    test "deletes candidate in listing", %{conn: conn, candidate: candidate} do
      {:ok, index_live, _html} = live(conn, ~p"/candidates")

      assert index_live |> element("#candidates-#{candidate.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#candidates-#{candidate.id}")
    end
  end

  describe "Show" do
    setup [:create_candidate]

    test "displays candidate", %{conn: conn, candidate: candidate} do
      {:ok, _show_live, html} = live(conn, ~p"/candidates/#{candidate}")

      assert html =~ "Show Candidate"
      assert html =~ candidate.cpvi
    end

    test "updates candidate within modal", %{conn: conn, candidate: candidate} do
      {:ok, show_live, _html} = live(conn, ~p"/candidates/#{candidate}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Candidate"

      assert_patch(show_live, ~p"/candidates/#{candidate}/show/edit")

      assert show_live
             |> form("#candidate-form", candidate: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#candidate-form", candidate: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/candidates/#{candidate}")

      html = render(show_live)
      assert html =~ "Candidate updated successfully"
      assert html =~ "some updated cpvi"
    end
  end
end
