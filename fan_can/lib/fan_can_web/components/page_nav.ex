defmodule FanCanWeb.Components.PageNav do
  use Phoenix.Component

  # This API sucks. & can't get real IP from Docker.

  def display(assigns) do
    ~H"""
      <div class="bg-slate-600 text-white border-solid border-2 border-white inline">
      <p><span>Page Nav</span><span class="mx-4">Select Sort Here</span></p>
        <ul>
          <%= for g <- @enum do %>
            <li><a href={ List.first(g["urls"]) }><%= g["name"] %></a></li>
          <%= end %>
        </ul>
      </div>
    """
  end
end