defmodule FanCanWeb.StateLive.Index do
  use FanCanWeb, :live_view

  alias FanCan.Public
  alias FanCan.Public.State

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :states, Public.list_states())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit State")
    |> assign(:state, Public.get_state!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New State")
    |> assign(:state, %State{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing States")
    |> assign(:state, nil)
  end

  @impl true
  def handle_info({FanCanWeb.StateLive.FormComponent, {:saved, state}}, socket) do
    {:noreply, stream_insert(socket, :states, state)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    state = Public.get_state!(id)
    {:ok, _} = Public.delete_state(state)

    {:noreply, stream_delete(socket, :states, state)}
  end
end
