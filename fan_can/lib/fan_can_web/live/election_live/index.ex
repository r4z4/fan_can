defmodule FanCanWeb.ElectionLive.Index do
  use FanCanWeb, :live_view

  alias FanCan.Public
  alias FanCan.Public.Election

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :elections, Public.list_elections_and_ballots())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Election")
    |> assign(:election, Public.get_election!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Election")
    |> assign(:election, %Election{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Elections")
    |> assign(:election, nil)
  end

  @impl true
  def handle_info({FanCanWeb.ElectionLive.FormComponent, {:saved, election}}, socket) do
    {:noreply, stream_insert(socket, :elections, election)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    election = Public.get_election!(id)
    {:ok, _} = Public.delete_election(election)

    {:noreply, stream_delete(socket, :elections, election)}
  end
end
