defmodule FanCanWeb.ThreadLiveTest do
  use FanCanWeb.ConnCase

  import Phoenix.LiveViewTest
  import FanCan.Site.ForumFixtures

  @create_attrs %{content: "some content", creator: "some creator", downvotes: 42, title: "some title", upvotes: 42}
  @update_attrs %{content: "some updated content", creator: "some updated creator", downvotes: 43, title: "some updated title", upvotes: 43}
  @invalid_attrs %{content: nil, creator: nil, downvotes: nil, title: nil, upvotes: nil}

  defp create_thread(_) do
    thread = thread_fixture()
    %{thread: thread}
  end

  describe "Index" do
    setup [:create_thread]

    test "lists all threads", %{conn: conn, thread: thread} do
      {:ok, _index_live, html} = live(conn, ~p"/threads")

      assert html =~ "Listing Threads"
      assert html =~ thread.content
    end

    test "saves new thread", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/threads")

      assert index_live |> element("a", "New Thread") |> render_click() =~
               "New Thread"

      assert_patch(index_live, ~p"/threads/new")

      assert index_live
             |> form("#thread-form", thread: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#thread-form", thread: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/threads")

      html = render(index_live)
      assert html =~ "Thread created successfully"
      assert html =~ "some content"
    end

    test "updates thread in listing", %{conn: conn, thread: thread} do
      {:ok, index_live, _html} = live(conn, ~p"/threads")

      assert index_live |> element("#threads-#{thread.id} a", "Edit") |> render_click() =~
               "Edit Thread"

      assert_patch(index_live, ~p"/threads/#{thread}/edit")

      assert index_live
             |> form("#thread-form", thread: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#thread-form", thread: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/threads")

      html = render(index_live)
      assert html =~ "Thread updated successfully"
      assert html =~ "some updated content"
    end

    test "deletes thread in listing", %{conn: conn, thread: thread} do
      {:ok, index_live, _html} = live(conn, ~p"/threads")

      assert index_live |> element("#threads-#{thread.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#threads-#{thread.id}")
    end
  end

  describe "Show" do
    setup [:create_thread]

    test "displays thread", %{conn: conn, thread: thread} do
      {:ok, _show_live, html} = live(conn, ~p"/threads/#{thread}")

      assert html =~ "Show Thread"
      assert html =~ thread.content
    end

    test "updates thread within modal", %{conn: conn, thread: thread} do
      {:ok, show_live, _html} = live(conn, ~p"/threads/#{thread}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Thread"

      assert_patch(show_live, ~p"/threads/#{thread}/show/edit")

      assert show_live
             |> form("#thread-form", thread: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#thread-form", thread: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/threads/#{thread}")

      html = render(show_live)
      assert html =~ "Thread updated successfully"
      assert html =~ "some updated content"
    end
  end
end
