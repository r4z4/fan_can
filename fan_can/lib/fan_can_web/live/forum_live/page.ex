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

  def handle_event("star_click", _value, socket) do
    thread = Site.get_thread!(id)
    Site.update_thread(thread, %{upvotes: thread.upvotes + 1})
    # Add pubsub msg
    upvoted_message = %{type: :thread, string: "Hey! User #{socket.assigns.current_user.id} upvoted your thread :)"}
    FanCanWeb.Endpoint.broadcast!("threads_" <> thread.creator, "new_message", upvoted_message)
    {:noreply, socket}
  end

  def handle_event("share_click", _value, socket) do
    thread = Site.get_thread!(id)
    Site.update_thread(thread, %{shares: thread.shares + 1})
    # Add pubsub msg
    shared_message = %{type: :thread, string: "Hey! User #{socket.assigns.current_user.id} shared your thread :)"}
    FanCanWeb.Endpoint.broadcast!("threads_" <> thread.creator, "new_message", shared_message)
    {:noreply, socket}
  end

  defp page_title(:page), do: "Show Forum"
  defp page_title(:edit), do: "Edit Forum"
end
