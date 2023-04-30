defmodule FanCan.Site.ForumFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FanCan.Site.Forum` context.
  """

  @doc """
  Generate a thread.
  """
  def thread_fixture(attrs \\ %{}) do
    {:ok, thread} =
      attrs
      |> Enum.into(%{
        content: "some content",
        creator: "some creator",
        downvotes: 42,
        title: "some title",
        upvotes: 42
      })
      |> FanCan.Site.Forum.create_thread()

    thread
  end

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        author: "some author",
        content: "some content",
        likes: 42,
        shares: 42,
        title: "some title"
      })
      |> FanCan.Site.Forum.create_post()

    post
  end
end
