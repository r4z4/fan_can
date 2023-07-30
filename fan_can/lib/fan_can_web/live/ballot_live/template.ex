defmodule FanCanWeb.BallotLive.Template do
  use FanCanWeb, :live_view

  alias FanCan.Public.Election
  alias FanCan.Public.Election.{BallotRace, Ballot}
  alias FanCan.Accounts.UserHolds
  alias FanCan.Accounts
  alias FanCanWeb.Components.{BallotEntry, LegBallotEntry, BallotEntryForm}

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
      x.hold_cat_id
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
        # candidates = Election.get_candidates(ballot_race.id)
        candidates = Election.get_legislators(socket.assigns.state_id)
        new = 
          Map.replace(ballot_race, :candidates, candidates)
      end
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:ballot, Election.get_ballot!(id))
     |> assign(:ballot_form, nil)
     |> assign(:ballot_races, final_ballot_races)
     |> assign(:election_id, Map.fetch!(List.first(final_ballot_races), :election_id))
     |> assign(:desc, List.first(ballot_races).desc)}
  end

  @impl true
  def handle_event("bell_click", %{"id" => id}, socket) do
    attrs = %{id: Ecto.UUID.generate(), user_id: socket.assigns.current_user.id, type: :alert, hold_cat: :race, hold_cat_id: id}
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

  @impl true
  def handle_event("bookmark_click", %{"id" => id, "desc" => desc}, socket) do
    attrs = %{id: Ecto.UUID.generate(), user_id: socket.assigns.current_user.id, type: :bookmark, hold_cat: :race, hold_cat_id: id}
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

  def add_or_replace(attrs, candidate_ids, socket) do
    IO.inspect(socket.assigns.vote_list, label: "Vote List")
    IO.inspect(candidate_ids, label: "candidate_ids")
    # race = Enum.find(socket.assigns.ballot_races, fn br -> br = district end)
    # opponents =       
    #   Enum.filter(race.candidates, fn(c) -> if c.id != attrs.candidate_id, do: c.id, else: nil end)
    # IO.inspect(opponents, label: "Opponent")
    has_voted = Enum.find(socket.assigns.vote_list, fn v -> v in candidate_ids end)
    IO.inspect(has_voted, label: "Has Voted")
    if has_voted do
      case Election.unregister_vote(has_voted, :candidate) do # Remove Previous Vote
        {:ok, struct} -> 
          case Election.register_vote(attrs) do
            {:ok, holds} -> 
              IO.inspect(holds, label: "Holds: ")
              {:noreply,
                socket
                |> assign(:vote_list, [attrs.hold_cat_id | List.delete(socket.assigns.vote_list, has_voted)])
                |> put_flash(:info, "Successfully voted for: #{attrs.hold_cat_id}")}

            {:error, %Ecto.Changeset{} = changeset} ->
              IO.inspect(changeset, label: "Holds Error: ")
              {:noreply, 
                socket
                |> put_flash(:error, "Error adding alert for #{attrs.hold_cat_id}")}
          end

        {:error, %Ecto.Changeset{} = changeset} ->
          IO.inspect(changeset, label: "Holds Error: ")
          {:noreply, socket}
      end
    else
      case Election.register_vote(attrs) do
        {:ok, holds} -> 
          IO.inspect(holds, label: "Holds: ")
          {:noreply,
            socket
            |> assign(:vote_list, [attrs.hold_cat_id | socket.assigns.vote_list])
            |> put_flash(:info, "Successfully voted for: #{attrs.hold_cat_id}")}

        {:error, %Ecto.Changeset{} = changeset} ->
          IO.inspect(changeset, label: "Holds Error: ")
          {:noreply, 
            socket
            |> put_flash(:error, "Error adding alert for #{attrs.hold_cat_id}")}
      end
    end
  end

  @impl true
  def handle_event("vote_casted", params, socket) do
    IO.inspect(params, label: "Params")
    # idx = List.to_string(params["_target"])
    # {int_val, ""} = Integer.parse(idx)
    # id = params[idx]
    attrs = %{id: Ecto.UUID.generate(), user_id: socket.assigns.current_user.id, type: :vote, hold_cat: :candidate, hold_cat_id: params["id"]}
    IO.inspect(attrs, label: "Vote Casted Attrs")
    IO.inspect(socket.assigns.ballot_form, label: "Assigns")
    # Governor race has no distrcit. How we handling that?
    {district, ""} = Integer.parse(params["value"])
    IO.inspect(district, label: "Vote Casted District")
    race = Enum.find(socket.assigns.ballot_races, fn x -> x.district == district end)
    candidate_ids = Enum.map(race.candidates, fn x -> x.id end)
    race_vote = %{district => district, }
    add_or_replace(attrs, candidate_ids, socket)
  end

  # def handle_event("vote_casted", %{"1" => id, "_target" => target}, socket) do
  #   IO.inspect(target, label: "Target")
  #   IO.puts(id)
  #   {:noreply, socket}
  # end

  # def handle_event("vote_casted", %{"2" => id, "_target" => target}, socket) do
  #   IO.inspect(target, label: "Target")
  #   IO.puts(id)
  #   {:noreply, socket}
  # end

  @impl true
  def handle_event("submit_ballot", _vals, socket) do
    ballot_form = format_vote_map(socket.assigns.vote_list, socket.assigns.election_id, socket.assigns.ballot_races)
    attrs = %{id: socket.assigns.ballot.id, user_id: socket.assigns.current_user.id, vote_map: ballot_form, submitted: true, election_id: socket.assigns.election_id, updated_at: NaiveDateTime.utc_now()}
      case Election.register_ballot(attrs) do
        {:ok, ballot} -> 
          {:noreply,
            socket
            |> put_flash(:info, "Successfully Submitted Ballot")
            |> push_navigate(to: ~p"/elections/main")}

        {:error, %Ecto.Changeset{} = changeset} ->
          {:noreply, 
            socket
            |> put_flash(:error, "Error Submitting Ballot")}
      end
  end
  
  def format_vote_map(vote_list, election_id, ballot_races) do
    IO.inspect(ballot_races, label: "FMV Ballot Races")
    IO.inspect(vote_list, label: "Vote List")
    # IO.inspect(first_map, label: "First Map")

    ballot_list = Enum.map(ballot_races, fn br -> %{:district => br.district, :candidates => Enum.map(br.candidates, fn c -> c.id end)} end) 
                 |> Enum.map(fn x -> if intersected = MapSet.intersection(MapSet.new(x.candidates), MapSet.new(vote_list)), do: Map.put(x, :votes, MapSet.to_list(intersected)), else: Map.put(x, :votes, []) end)
    ballot_map = Map.new() |> Map.put(String.to_atom(election_id), ballot_list)
    # IO.inspect(ballot_map, label: "ballot_map")

    # %Ballot{id: ballot.id, user_id: current_user.id, vote_map: %{}}
  end

  defp page_title(:template), do: "Ballot For ..."
end
