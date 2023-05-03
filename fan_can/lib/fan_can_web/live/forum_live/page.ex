defmodule FanCanWeb.ForumLive.Page do
  use FanCanWeb, :live_view

  alias FanCan.Site
  alias FanCan.Site.Forum

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:forum, Site.get_forum!(id))
     |> assign(:threads, Forum.get_forum_threads(id))}
  end

  defp page_title(:page), do: "Show Forum"
  defp page_title(:edit), do: "Edit Forum"
end
