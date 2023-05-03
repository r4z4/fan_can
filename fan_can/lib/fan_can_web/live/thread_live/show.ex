defmodule FanCanWeb.ThreadLive.Show do
  use FanCanWeb, :live_view

  alias FanCan.Site.Forum
  alias FanCan.Site.Forum.Thread

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:thread, Forum.get_thread!(id))
     |> assign(:posts, Forum.get_thread_posts(id))}
  end

  def handle_event("upvote_click", _value, socket) do
    IO.puts("Upvoted")
    {:noreply, socket}
  end

  def handle_event("downvote_click", _value, socket) do
    IO.puts("Downvoted")
    {:noreply, socket}
  end

  defp page_title(:show), do: "Posts for Thread"
  defp page_title(:edit), do: "Edit Thread"
end
