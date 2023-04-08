defmodule FanCanWeb.CandidateLive.Index do
  use FanCanWeb, :live_view

  alias FanCan.Public
  alias FanCan.Public.Candidate

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :candidates, Public.list_candidates())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Candidate")
    |> assign(:candidate, Public.get_candidate!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Candidate")
    |> assign(:candidate, %Candidate{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Candidates")
    |> assign(:candidate, nil)
  end

  @impl true
  def handle_info({FanCanWeb.CandidateLive.FormComponent, {:saved, candidate}}, socket) do
    {:noreply, stream_insert(socket, :candidates, candidate)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    candidate = Public.get_candidate!(id)
    {:ok, _} = Public.delete_candidate(candidate)

    {:noreply, stream_delete(socket, :candidates, candidate)}
  end
end
