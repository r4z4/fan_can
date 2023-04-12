defmodule FanCanWeb.CandidateLive.Index do
  use FanCanWeb, :live_view

  alias FanCan.Public
  alias FanCan.Public.Candidate
  # @impl Phoenix.LiveView
  @impl true
  def mount(_params, _session, socket) do
    FanCanWeb.Endpoint.subscribe("topic")
    {:ok, 
     socket
     |> stream(:candidates, Public.list_candidates())
     |> stream(:messages, [])}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Candidate")
    |> assign(:messages, [])
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

  @impl true
  def handle_info(%{event: "new_message", payload: new_message}, socket) do
    updated_messages = socket.assigns[:messages] ++ [new_message]
    IO.inspect(new_message, label: "New Message")

    {:noreply, 
     socket 
     |> assign(:messages, updated_messages)
     |> put_flash(:info, "PubSub: #{new_message}")}
  end
end
