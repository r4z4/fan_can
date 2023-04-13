defmodule FanCanWeb.CandidateLive.Index do
  use FanCanWeb, :live_view

  alias FanCan.Public
  alias FanCan.Public.Candidate
  alias FanCan.Accounts
  # @impl Phoenix.LiveView
  @impl true
  def mount(_params, session, socket) do
    # {email, username} = Accounts.get_user_data_by_token(session["user_token"])
    # %{entries: entries, page_number: page_number, page_size: page_size, total_entries: total_entries, total_pages: total_pages}
    FanCanWeb.Endpoint.subscribe("topic")
    result = if connected?(socket), do: Public.paginate_candidates(), else: %Scrivener.Page{}
    # assigns = [
    #   candidates: result.entries,
    #   page_number: result.page_number || 0,
    #   page_size: result.page_size || 0,
    #   total_entries: result.total_entries || 0,
    #   total_pages: result.total_pages || 0
    # ]

    IO.inspect(result, label: "Result")

    {:ok, 
     socket
     |> stream(:candidates, result.entries)
     |> stream(:messages, [])
     |> assign(:page_number, result.page_number || 0)
     |> assign(:page_size, result.page_size || 0)
     |> assign(:total_entries, result.total_entries || 0)
     |> assign(:total_pages, result.total_pages || 0)}
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

  defp apply_action(socket, :nav, %{"page_number" => page_number}) do
    socket
    |> assign(:page_number, page_number)
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

  def handle_params(_, _, socket) do
    assigns = get_and_assign_page(nil)
    {:noreply, assign(socket, assigns)}
  end

  def get_and_assign_page(page_number) do
    %{
      entries: entries,
      page_number: page_number,
      page_size: page_size,
      total_entries: total_entries,
      total_pages: total_pages
    } = Products.paginate_products(page: page_number)

    [
      products: entries,
      page_number: page_number,
      page_size: page_size,
      total_entries: total_entries,
      total_pages: total_pages
    ]
  end
end
