defmodule FanCan.SiteTest do
  use FanCan.DataCase

  alias FanCan.Site

  describe "forums" do
    alias FanCan.Site.Forum

    import FanCan.SiteFixtures

    @invalid_attrs %{category: nil, subscribers: nil, title: nil}

    test "list_forums/0 returns all forums" do
      forum = forum_fixture()
      assert Site.list_forums() == [forum]
    end

    test "get_forum!/1 returns the forum with given id" do
      forum = forum_fixture()
      assert Site.get_forum!(forum.id) == forum
    end

    test "create_forum/1 with valid data creates a forum" do
      valid_attrs = %{category: "some category", subscribers: [], title: "some title"}

      assert {:ok, %Forum{} = forum} = Site.create_forum(valid_attrs)
      assert forum.category == "some category"
      assert forum.subscribers == []
      assert forum.title == "some title"
    end

    test "create_forum/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Site.create_forum(@invalid_attrs)
    end

    test "update_forum/2 with valid data updates the forum" do
      forum = forum_fixture()
      update_attrs = %{category: "some updated category", subscribers: [], title: "some updated title"}

      assert {:ok, %Forum{} = forum} = Site.update_forum(forum, update_attrs)
      assert forum.category == "some updated category"
      assert forum.subscribers == []
      assert forum.title == "some updated title"
    end

    test "update_forum/2 with invalid data returns error changeset" do
      forum = forum_fixture()
      assert {:error, %Ecto.Changeset{}} = Site.update_forum(forum, @invalid_attrs)
      assert forum == Site.get_forum!(forum.id)
    end

    test "delete_forum/1 deletes the forum" do
      forum = forum_fixture()
      assert {:ok, %Forum{}} = Site.delete_forum(forum)
      assert_raise Ecto.NoResultsError, fn -> Site.get_forum!(forum.id) end
    end

    test "change_forum/1 returns a forum changeset" do
      forum = forum_fixture()
      assert %Ecto.Changeset{} = Site.change_forum(forum)
    end
  end
end
