defmodule FanCanWeb.BallotLive.Index do
  use FanCanWeb, :live_view

  alias FanCan.Public.Election
  alias FanCan.Public.Election.Ballot

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :ballots, Election.list_ballots())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Ballot")
    |> assign(:ballot, Election.get_ballot!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Ballot")
    |> assign(:ballot, %Ballot{})
  end

  defp apply_action(socket, :template, _params) do
    socket
    |> assign(:page_title, "Ballot Template")
    |> assign(:ballot, nil)
  end

  @impl true
  def handle_info({FanCanWeb.BallotLive.FormComponent, {:saved, ballot}}, socket) do
    {:noreply, stream_insert(socket, :ballots, ballot)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    ballot = Election.get_ballot!(id)
    {:ok, _} = Election.delete_ballot(ballot)

    {:noreply, stream_delete(socket, :ballots, ballot)}
  end
end
