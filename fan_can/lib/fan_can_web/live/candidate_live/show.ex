defmodule FanCanWeb.CandidateLive.Show do
  use FanCanWeb, :live_view

  alias FanCan.Public
  alias FanCan.Core
  alias FanCan.Core.Utils

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    candidate = Public.get_candidate!(id)
    image_path =
    if candidate.attachments && List.first(candidate.attachments) do
      image = Core.get_attachment!(List.first(candidate.attachments))
      image.path
    else
      Utils.no_image
    end

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:candidate, candidate)
     |> assign(:image_path, image_path)}
  end

  defp page_title(:show), do: "Show Candidate"
  defp page_title(:edit), do: "Edit Candidate"
end
