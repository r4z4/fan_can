defmodule FanCanWeb.BallotLive.Template do
  use FanCanWeb, :live_view

  alias FanCan.Public.Election
  alias FanCan.Public.Election.BallotRace

# @type ballot_map :: %{
#    id: String.t,
#    candidates: [binary]
# }

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  defp party_class(party) do
    case party do
      :Democrat -> "ml-3 text-blue"
      :Republican -> "ml-3 text-red"
      :Independent -> "ml-3 text-black"
      :Now -> "ml-3 text-green"
      :Libertarian -> "ml-3 text-purple"
      :Non_Partisan -> "ml-3 text-black"
      :Other_Party -> "ml-3 text-amber"
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
        IO.inspect(candidates, label: "Candidates")
        new = Map.replace(ballot_race, :candidates, candidates)
      end
    IO.inspect(final_ballot_races, label: "Final Ballot Races")
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:ballot_races, final_ballot_races)
     |> assign(:desc, List.first(ballot_races).desc)
     |> assign(:date, List.first(ballot_races).election_date)}
  end

  defp page_title(:template), do: "Ballot For ..."
end
