defmodule FanCanWeb.Components.CatStats do
  use Phoenix.Component

  # This API sucks. & can't get real IP from Docker.

  def display(assigns) do
    ~H"""
      <div class="mt-10 space-y-8 bg-slate-400 text-center text-white">
      <h4>Quick Look at this <%= @cat %></h4>
        <p><%= @obj.title %></p>
        <p># Members: <%= Kernel.length(@obj.members) %></p>
        <p># Shares: <%= @obj.shares %></p>
      </div>
    """
  end
end