defmodule FanCanWeb.BallotLive.Template do
  use FanCanWeb, :live_view

  alias FanCan.Public.Election
  alias FanCan.Public.Election.BallotRace
  alias FanCan.Accounts.UserHolds
  alias FanCan.Accounts

# @type ballot_map :: %{
#    id: String.t,
#    candidates: [binary]
# }

  @impl true
  def mount(_params, _session, socket) do
    vote_list = 
      Enum.filter(socket.assigns.current_user_holds.candidate_holds, fn hold -> Map.fetch!(hold, :type) == :vote end)
      |> comprehend()

    {:ok, 
      socket
      |> assign(:vote_list, vote_list)}
  end

  defp comprehend(list) do
    for x <- list do
      x.candidate_id
    end
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
    attrs = %{id: Ecto.UUID.generate(), user_id: socket.assigns.current_user.id, type: :alert, race_id: id}
      # FIXME: Move to RegisterHandlers
      case Election.register_alert(attrs) do
        {:ok, holds} -> 
          IO.inspect(holds, label: "Holds: ")
          {:noreply,
            socket
            |> put_flash(:info, "We have set an alert for Race: #{holds.id}")}

        {:error, %Ecto.Changeset{} = changeset} ->
          IO.inspect(changeset, label: "Holds Error: ")
          {:noreply, 
            socket
            |> put_flash(:error, "Error adding alert")}
      end
  end

  def handle_event("bookmark_click", %{"id" => id, "desc" => desc}, socket) do
    attrs = %{id: Ecto.UUID.generate(), user_id: socket.assigns.current_user.id, type: :bookmark, race_id: id}
      # FIXME: Move to RegisterHandlers
      case Election.register_bookmark(attrs) do
        {:ok, holds} -> 
          IO.inspect(holds, label: "Holds: ")
          {:noreply,
            socket
            |> put_flash(:info, "Successfully bookmarked race: #{desc}")}

        {:error, %Ecto.Changeset{} = changeset} ->
          IO.inspect(changeset, label: "Holds Error: ")
          {:noreply, 
            socket
            |> put_flash(:error, "Error adding alert for #{desc}")}
      end
  end

  def voted_for?(id, holds) do
    Enum.member?(holds, id)
  end

  def handle_event("vote_casted", %{"0" => id, "_target" => target}, socket) do
    IO.inspect(target, label: "Target")
    IO.puts(id)
    {:noreply, socket}
  end

  def handle_event("vote_casted", %{"1" => id, "_target" => target}, socket) do
    IO.inspect(target, label: "Target")
    IO.puts(id)
    {:noreply, socket}
  end

  def handle_event("vote_casted", %{"2" => id, "_target" => target}, socket) do
    IO.inspect(target, label: "Target")
    IO.puts(id)
    {:noreply, socket}
  end

  def handle_event("save", _vals, socket) do
    IO.puts("Handler")
    {:noreply, socket}
  end

  defp page_title(:template), do: "Ballot For ..."
end
