defmodule FanCanWeb.Components.StateSnapshot do
  use Phoenix.Component

  # This API sucks. & can't get real IP from Docker.

  def display(assigns) do
    ~H"""
      <div class="mt-10 space-y-8 bg-slate-400 text-center text-white">
      <h4>State Snapshot</h4>
        <ul>
          <%= for g <- @g_candidates["officials"] do %>
            <li><a href={ List.first(g["urls"]) }><%= g["name"] %></a></li>
          <%= end %>
        </ul>
      </div>
    """
  end
end