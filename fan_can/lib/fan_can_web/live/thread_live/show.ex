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

  def handle_event("like_click", %{"id" => id}, socket) do
    post = Forum.get_post!(id)
    Forum.update_post(post, %{likes: post.likes + 1})
    # Add pubsub msg
    upvoted_message = %{type: :post, string: "Hey! User #{socket.assigns.current_user.id} upvoted your post :)"}
    IO.inspect(liked_message, label: "liked_message")
    FanCanWeb.Endpoint.broadcast!("posts_" <> post.author, "new_message", liked_message)
    {:noreply, socket}
  end

  def handle_event("share_click", %{"id" => id}, socket) do
    post = Forum.get_post!(id)
    Forum.update_post(post, %{shares: post.shares + 1})
    # Add pubsub msg
    downvoted_message = %{type: :post, string: "Hey! User #{socket.assigns.current_user.id} downvoted your post :)"}
    FanCanWeb.Endpoint.broadcast!("posts_" <> post.author, "new_message", liked_message)
    {:noreply, socket}
  end

  defp page_title(:show), do: "Posts for Thread"
  defp page_title(:edit), do: "Edit Thread"
end
