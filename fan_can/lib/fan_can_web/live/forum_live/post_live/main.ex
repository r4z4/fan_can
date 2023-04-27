defmodule FanCanWeb.ForumLive.PostLive.Main do
  use FanCanWeb, :live_view

  alias FanCan.Site
  alias FanCan.Site.Forum
  alias FanCan.Site.Forum.Post
  alias FanCan.Site.Forum.Thread

# @type ballot_map :: %{
#    id: String.t,
#    candidates: [binary]
# }

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  defp candidate_class(candidate) do
    case candidate.incumbent_since do
      _ -> "font-bold"
    end
  end

  # @impl true
  # def mount(%{"id" => id}, _session, socket) do
  #   {:ok, stream(socket, :ballots, Election.get_ballot!(id))}
  # end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    posts = Site.get_thread_posts(id)
    IO.inspect(posts, label: "Posts")
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:post_form, nil)
     |> assign(:posts, posts)}
  end

  defp page_title(:main), do: "Forum Title Here"
end
