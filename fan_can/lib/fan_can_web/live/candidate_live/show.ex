defmodule FanCanWeb.CandidateLive.Show do
  use FanCanWeb, :live_view

  alias FanCan.Public
  alias FanCan.Core
  alias FanCan.Core.Utils

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok, 
     socket
     |> assign(:uploaded_files, [])
     |> assign(:file, nil)
     |> allow_upload(:avatar, accept: ~w(.jpg .jpeg), max_entries: 2)}
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

@impl Phoenix.LiveView
def handle_event("upload", _params, socket) do
  uploaded_files =
    consume_uploaded_entries(socket, :avatar, fn %{path: path}, _entry ->
      dest = Path.join([:code.priv_dir(:fan_can), "static", "uploads", Path.basename(path)])
      # The `static/uploads` directory must exist for `File.cp!/2`
      # and MyAppWeb.static_paths/0 should contain uploads to work,.
      File.cp!(path, dest)
      {:ok, ~p"/uploads/#{Path.basename(dest)}"}
    end)

  {:noreply, update(socket, :uploaded_files, &(&1 ++ uploaded_files))}
end

  @impl Phoenix.LiveView
  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  defp page_title(:show), do: "Show Candidate"
  defp page_title(:edit), do: "Edit Candidate"
end
