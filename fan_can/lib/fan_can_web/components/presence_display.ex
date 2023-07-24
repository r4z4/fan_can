defmodule FanCanWeb.Components.PresenceDisplay do
  use Phoenix.LiveComponent
  alias FanCan.Presence
  #{u.username, u.email, u.confirmed_at, us.easy_games_played, us.easy_games_finished, us.med_games_played, us.med_games_finished, us.hard_games_played, us.hard_games_finished, 
  # us.easy_poss_pts, us.easy_earned_pts, us.med_poss_pts, us.med_earned_pts, us.hard_poss_pts, us.hard_earned_pts}

  def mount(_params, _session, socket) do
    IO.inspect(socket, label: "Component Socket")
    # # before subscribing, get current_player_count
    # topic = "home_page"
    # initial_count = Presence.list(topic) |> map_size

    # # Subscribe to the topic
    # FanCanWeb.Endpoint.subscribe(topic)

    # # Track changes to the topic
    # Presence.track(
    #   self(),
    #   topic,
    #   socket.id,
    #   %{}
    # )
    # Assigning to parent LV socket. Use thin_wrapper
    {:ok, socket}
  end

  def update(assigns, socket) do
    IO.inspect(self(), label: "UPDATE")
    socket = assign(socket, assigns)

    # before subscribing, get current_player_count
    topic = "home_page"
    initial_count = Presence.list(topic) |> map_size

    # Subscribe to the topic
    FanCanWeb.Endpoint.subscribe(topic)

    # Track changes to the topic
    Presence.track(
      self(),
      topic,
      socket.id,
      %{}
    )

    {:ok,
      socket
      |> assign(:social_count, initial_count)}
  end

  def render(assigns) do
    ~H"""
    <section class="relative top-0 left-0">
      <div class="container px-5 mx-auto">
        <div class="grid grid-cols-1 items-center justify-center">
          <!-- Card -->
          <div class="flex p-4 w-full hover:scale-105 duration-500">
            <div class=" flex items-center justify-between p-4 rounded-lg bg-white shadow-indigo-50 shadow-md">
              <div>
                <h3 class="text-fuchsia-700 text-md">Users In Lobby: <%= @social_count %> </h3>
              </div>
            </div>
          </div>
          <!-- End Card -->
        </div>
      </div>
    </section>
    """
  end

  def handle_info(
        %{event: "presence_diff", payload: %{joins: joins, leaves: leaves}},
        %{assigns: %{social_count: count}} = socket
      ) do
    social_count = count + map_size(joins) - map_size(leaves)

    {:noreply, assign(socket, :social_count, social_count)}
  end

  def handle_event("social", _value, socket) do
    {:noreply, 
      socket 
      |> push_redirect(to: "/forums/main")}
    # Get back to using changesets
    # {:noreply, assign(socket |> assign(changeset: changeset))}
  end
end