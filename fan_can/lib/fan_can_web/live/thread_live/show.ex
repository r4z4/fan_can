defmodule FanCanWeb.ThreadLive.Show do
  use FanCanWeb, :live_view

  alias FanCan.Site.Forum
  alias FanCan.Site.Forum.Thread
  alias FanCan.Site.Forum.Post

  @impl true
  def mount(_params, _session, socket) do
    {:ok, 
      socket
      |> assign(:post_upvote_ids, Enum.filter(socket.assigns.current_user_holds.post_holds, fn ph -> ph.type == :upvote end) |> Enum.map(fn ph -> ph.hold_cat_id end))
      |> assign(:post_downvote_ids, Enum.filter(socket.assigns.current_user_holds.post_holds, fn ph -> ph.type == :downvote end) |> Enum.map(fn ph -> ph.hold_cat_id end))}
  end

  defp apply_action(socket, :new_post, _params) do
    socket
    |> assign(:page_title, "New Post Son")
    |> assign(:thread, %Thread{})
    |> assign(:post, %Post{})
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    IO.inspect(socket.assigns.post_upvote_ids, label: "PUIDs")
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:thread, Forum.get_thread!(id))
     |> assign(:posts, Forum.get_thread_posts(id))}
  end

  @impl true
  def handle_event("upvote_click", %{"id" => id}, socket) do
    post = Forum.get_post!(id)
    IO.inspect(post, label: "post")
    Forum.update_post(post, %{upvotes: post.upvotes + 1})
    # Add pubsub msg
    upvoted_message = %{type: :post, string: "Hey! User #{socket.assigns.current_user.id} upvoted your post :)"}
    IO.inspect(upvoted_message, label: "upvoted_message")
    FanCanWeb.Endpoint.broadcast!("posts_" <> post.author, "new_message", upvoted_message)
    {:noreply, socket}
  end

  @impl true
  def handle_event("downvote_click", %{"id" => id}, socket) do
    post = Forum.get_post!(id)
    Forum.update_post(post, %{downvotes: post.downvotes + 1})
    # Add pubsub msg
    downvoted_message = %{type: :post, string: "Hey! User #{socket.assigns.current_user.id} downvoted your post :)"}
    FanCanWeb.Endpoint.broadcast!("posts_" <> post.author, "new_message", downvoted_message)
    {:noreply, socket}
  end

  defp page_title(:show), do: "Posts for Thread"
  defp page_title(:edit), do: "Edit Thread"
  defp page_title(:new_post), do: "New Post"
end
