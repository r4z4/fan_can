defmodule FanCanWeb.BallotLive.Template do
  use FanCanWeb, :live_view

  alias FanCan.Public.Election
  alias FanCan.Public.Election.BallotRace
  alias FanCan.Accounts.UserFollows
  alias FanCan.Accounts

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
      :Democrat -> "ml-3 text-sky-300"
      :Republican -> "ml-3 text-pink-300"
      :Independent -> "ml-3 text-emerald-300"
      :Now -> "ml-3 text-green"
      :Libertarian -> "ml-3 text-purple-200"
      :Non_Partisan -> "ml-3 text-fuchsia-300"
      :Other_Party -> "ml-3 text-amber"
    end
  end

  defp party_name(party) do
    case party do
      :Democrat -> "Dem"
      :Republican -> "Rep"
      :Independent -> "Ind"
      :Now -> "Now"
      :Libertarian -> "Lib"
      :Non_Partisan -> "Non-P"
      :Other_Party -> "Other"
    end
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
        new = 
          Map.replace(ballot_race, :candidates, candidates)
      end
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:ballot_form, nil)
     |> assign(:ballot_races, final_ballot_races)
     |> assign(:desc, List.first(ballot_races).desc)
     |> assign(:date, List.first(ballot_races).election_date)}
  end

  def handle_event("bell_click", %{"id" => id}, socket) do
    race = Election.get_race!(id)
    Election.update_race(race, %{alerts: race.alerts + 1})
    attrs = %{id: Ecto.UUID.generate(), user_id: socket.assigns.current_user.id, type: :race, follow_ids: [id]}
      case Accounts.register_user_follows(attrs) do
        {:ok, user_follows} -> IO.inspect(user_follows, label: "User Follows: ")
        {:error, err} -> IO.puts "User Follows Registration Error #{err}"
      end
    {:noreply, socket}
  end

  def handle_event("save", _vals, socket) do
    IO.puts("Handler")
    {:noreply, socket}
  end

  defp page_title(:template), do: "Ballot For ..."
end
