defmodule FanCan.Site.ForumTest do
  use FanCan.DataCase

  alias FanCan.Site.Forum

  describe "threads" do
    alias FanCan.Site.Forum.Thread

    import FanCan.Site.ForumFixtures

    @invalid_attrs %{content: nil, creator: nil, downvotes: nil, title: nil, upvotes: nil}

    test "list_threads/0 returns all threads" do
      thread = thread_fixture()
      assert Forum.list_threads() == [thread]
    end

    test "get_thread!/1 returns the thread with given id" do
      thread = thread_fixture()
      assert Forum.get_thread!(thread.id) == thread
    end

    test "create_thread/1 with valid data creates a thread" do
      valid_attrs = %{content: "some content", creator: "some creator", downvotes: 42, title: "some title", upvotes: 42}

      assert {:ok, %Thread{} = thread} = Forum.create_thread(valid_attrs)
      assert thread.content == "some content"
      assert thread.creator == "some creator"
      assert thread.downvotes == 42
      assert thread.title == "some title"
      assert thread.upvotes == 42
    end

    test "create_thread/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Forum.create_thread(@invalid_attrs)
    end

    test "update_thread/2 with valid data updates the thread" do
      thread = thread_fixture()
      update_attrs = %{content: "some updated content", creator: "some updated creator", downvotes: 43, title: "some updated title", upvotes: 43}

      assert {:ok, %Thread{} = thread} = Forum.update_thread(thread, update_attrs)
      assert thread.content == "some updated content"
      assert thread.creator == "some updated creator"
      assert thread.downvotes == 43
      assert thread.title == "some updated title"
      assert thread.upvotes == 43
    end

    test "update_thread/2 with invalid data returns error changeset" do
      thread = thread_fixture()
      assert {:error, %Ecto.Changeset{}} = Forum.update_thread(thread, @invalid_attrs)
      assert thread == Forum.get_thread!(thread.id)
    end

    test "delete_thread/1 deletes the thread" do
      thread = thread_fixture()
      assert {:ok, %Thread{}} = Forum.delete_thread(thread)
      assert_raise Ecto.NoResultsError, fn -> Forum.get_thread!(thread.id) end
    end

    test "change_thread/1 returns a thread changeset" do
      thread = thread_fixture()
      assert %Ecto.Changeset{} = Forum.change_thread(thread)
    end
  end

  describe "posts" do
    alias FanCan.Site.Forum.Post

    import FanCan.Site.ForumFixtures

    @invalid_attrs %{author: nil, content: nil, likes: nil, shares: nil, title: nil}

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Forum.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Forum.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{author: "some author", content: "some content", likes: 42, shares: 42, title: "some title"}

      assert {:ok, %Post{} = post} = Forum.create_post(valid_attrs)
      assert post.author == "some author"
      assert post.content == "some content"
      assert post.likes == 42
      assert post.shares == 42
      assert post.title == "some title"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Forum.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      update_attrs = %{author: "some updated author", content: "some updated content", likes: 43, shares: 43, title: "some updated title"}

      assert {:ok, %Post{} = post} = Forum.update_post(post, update_attrs)
      assert post.author == "some updated author"
      assert post.content == "some updated content"
      assert post.likes == 43
      assert post.shares == 43
      assert post.title == "some updated title"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Forum.update_post(post, @invalid_attrs)
      assert post == Forum.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Forum.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Forum.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Forum.change_post(post)
    end
  end
end
