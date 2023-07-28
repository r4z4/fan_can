defmodule FanCanWeb.Components.PresenceDisplay do
  use Phoenix.LiveComponent
  alias FanCan.Presence
  alias FanCan.Accounts
  #{u.username, u.email, u.confirmed_at, us.easy_games_played, us.easy_games_finished, us.med_games_played, us.med_games_finished, us.hard_games_played, us.hard_games_finished, 
  # us.easy_poss_pts, us.easy_earned_pts, us.med_poss_pts, us.med_earned_pts, us.hard_poss_pts, us.hard_earned_pts}

  def mount(params, _session, socket) do
    IO.inspect(socket, label: "Component Socket")
    IO.inspect(params, label: "Component Params")
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
    {:ok, 
      socket
      |> assign(:room, params.room)}
  end

  def update(assigns, socket) do
    IO.inspect(self(), label: "UPDATE")
    IO.inspect(assigns.room, label: "ROOM")
    socket = assign(socket, assigns)

    # before subscribing, get current_player_count
    # topic = "Lobby"
    initial_count = Presence.list(assigns.room) |> map_size
    initial_user_id_list = Presence.list(assigns.room) |> Map.keys()
    initial_users = Presence.list(assigns.room) |> Accounts.get_users()

    # Subscribe to the topic
    FanCanWeb.Endpoint.subscribe(assigns.room)

    # Track changes to the topic
    Presence.track(
      self(),
      assigns.room,
      socket.id,
      %{
        username: username,
        joined_at: :os.system_time(:seconds)
      }
    )

    {:ok,
      socket
      |> assign(:user_id_list, initial_user_id_list)
      |> assign(:users, initial_users)
      |> assign(:social_count, initial_count)}
  end

  def render(assigns) do
    ~H"""
    <section class="relative top-0 left-0">
      <div class="flex items-center justify-center my-4">
          <!-- Card -->
            <%= for user <- assigns.users do %>
              <div class="flex">
                <div class=" flex items-center justify-between p-2 rounded-lg bg-white shadow-indigo-50 shadow-md">
                    <div class="content">
                      <div class="flex items-center justify-center">
                        <div :if={Enum.member?(@user_follow_holds, user.id)}>
                          <icon :if={user.id == assigns.current_user_id}>✴</icon>
                          <div :if={user.id in assigns.current_user_follows}>
                              <button phx-click="toggle_follow" value={ user.id } id="follow_btn">✅</button>{" "}
                          </div>
                        </div>
                        {user.username}
                      </div>
                  </div>
                </div>
              </div>
            <% end %>
          <!-- End Card -->
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