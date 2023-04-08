defmodule FanCan.SiteFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FanCan.Site` context.
  """

  @doc """
  Generate a forum.
  """
  def forum_fixture(attrs \\ %{}) do
    {:ok, forum} =
      attrs
      |> Enum.into(%{
        category: "some category",
        subscribers: [],
        title: "some title"
      })
      |> FanCan.Site.create_forum()

    forum
  end
end
