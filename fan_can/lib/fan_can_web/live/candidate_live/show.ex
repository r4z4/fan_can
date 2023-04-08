defmodule FanCanWeb.CandidateLive.Show do
  use FanCanWeb, :live_view

  alias FanCan.Public
  alias FanCan.Core

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    candidate = Public.get_candidate!(id)
    image = Core.get_attachment!(List.first(candidate.attachments))
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:candidate, candidate)
     |> assign(:image_path, image.path)}
  end

  defp page_title(:show), do: "Show Candidate"
  defp page_title(:edit), do: "Edit Candidate"
end
