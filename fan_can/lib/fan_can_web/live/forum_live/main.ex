defmodule FanCanWeb.ForumLive.Main do
  use FanCanWeb, :live_view

  alias FanCan.Site
  alias FanCan.Site.Forum

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :forums, Site.list_forums())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Forum")
    |> assign(:forum, Site.get_forum!(id))
  end

  defp apply_action(socket, :main, _params) do
    socket
    |> assign(:page_title, "Forum Main Page")
    |> assign(:forum, nil)
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Forum")
    |> assign(:forum, %Forum{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Forums")
    |> assign(:forum, nil)
  end

  defp get_forum_image(title) do
    case title do
      "The Nebraska Unicameral" -> "https://upload.wikimedia.org/wikipedia/commons/f/f0/Thinking_%2850377%29_-_The_Noun_Project.svg"
      "General Forum" -> "https://upload.wikimedia.org/wikipedia/commons/f/f0/Thinking_%2850377%29_-_The_Noun_Project.svg"
      "User's Forum" -> "https://upload.wikimedia.org/wikipedia/commons/f/f4/User_Avatar_2.png"
      "2024 Election" -> "https://upload.wikimedia.org/wikipedia/commons/8/89/Republican_v_Democrat_Gallup_08.svg"
      "Issues" -> "https://upload.wikimedia.org/wikipedia/commons/3/35/Adobe_Help_CS5_icon.png"
    end
  end

  @impl true
  def handle_info({FanCanWeb.ForumLive.FormComponent, {:saved, forum}}, socket) do
    {:noreply, stream_insert(socket, :forums, forum)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    forum = Site.get_forum!(id)
    {:ok, _} = Site.delete_forum(forum)

    {:noreply, stream_delete(socket, :forums, forum)}
  end
end
