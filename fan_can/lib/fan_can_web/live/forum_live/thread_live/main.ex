defmodule FanCanWeb.ForumLive.ThreadLive.Main do
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
    forum = Site.get_forum!(id)
    threads = Site.get_forum_threads(id)
    IO.inspect(threads, label: "Threads")
    {:noreply,
     socket
     |> assign(:page_title, forum.title)
     |> assign(:thread_form, nil)
     |> assign(:threads, threads)}
  end

end
