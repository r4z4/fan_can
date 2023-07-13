defmodule FanCanWeb.Components.VoterInfo do
  use Phoenix.Component

  attr :name, :string, required: true

  def greet(assigns) do
    ~H"""
    <p>Hello, <%= @name %>!</p>
    """
  end
end