defmodule FanCanWeb.ForumLive.Template do
  use FanCanWeb, :live_view

  alias FanCan.Site.Forum

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
    ballot_races = Election.get_ballot_races(id)
    final_ballot_races = 
      for ballot_race <- ballot_races do
        candidates = Election.get_candidates(ballot_race.id)
        image_path = "/images/ne_districts/District#{ballot_race.district}.png"
        IO.inspect(candidates, label: "Candidates")
        new = 
          Map.replace(ballot_race, :candidates, candidates)
          |> Map.put(:image_path, image_path)
      end
    IO.inspect(final_ballot_races, label: "Final Ballot Races")
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:post_form, nil)
     |> assign(:posts, final_ballot_races)
     |> assign(:desc, List.first(ballot_races).desc)
     |> assign(:date, List.first(ballot_races).election_date)}
  end

  defp page_title(:template), do: "Forum Title Here"
end
