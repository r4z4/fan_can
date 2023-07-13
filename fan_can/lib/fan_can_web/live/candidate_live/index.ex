defmodule FanCanWeb.CandidateLive.Index do
  use FanCanWeb, :live_view

  alias FanCan.Public
  alias FanCan.Public.Candidate
  alias FanCan.Accounts
  alias FanCan.Core.TopicHelpers
  alias FanCan.Accounts.UserFollows
  alias FanCan.Core.Utils

  # @impl Phoenix.LiveView
  @impl true
  def mount(_params, session, socket) do
    # {email, username} = Accounts.get_user_data_by_token(session["user_token"])
    # %{entries: entries, page_number: page_number, page_size: page_size, total_entries: total_entries, total_pages: total_pages}
    g_candidates = api_query(socket.assigns.current_user.state)
    FanCanWeb.Endpoint.subscribe("topic")
    result = if connected?(socket), do: Public.paginate_candidates(), else: %Scrivener.Page{}

    for follow = %UserFollows{} <- socket.assigns.current_user_follows do
      IO.inspect(follow, label: "Type")
      # Subscribe to user_follows. E.g. forums that user subscribes to
      case follow.type do
        :candidate -> TopicHelpers.subscribe_to_followers("candidate", follow.follow_ids)
        :user -> TopicHelpers.subscribe_to_followers("user", follow.follow_ids)
        :forum -> TopicHelpers.subscribe_to_followers("forum", follow.follow_ids)
        :election -> TopicHelpers.subscribe_to_followers("election", follow.follow_ids)
      end
    end

    with %{post_ids: post_ids, thread_ids: thread_ids} <- socket.assigns.current_user_published_ids do
      IO.inspect(thread_ids, label: "thread_ids_b")
      for post_id <- post_ids do
        FanCanWeb.Endpoint.subscribe("posts_" <> post_id)
      end
      for thread_id <- thread_ids do
        FanCanWeb.Endpoint.subscribe("threads_" <> thread_id)
      end
    end

    {:ok, 
     socket
     |> stream(:candidates, result.entries)
     |> stream(:stream_messages, [])
     |> assign(:g_candidates, g_candidates)
     # |> assign(:g_can_zip, Enum.zip(g_candidates["offices"], g_candidates["officials"]))
     |> assign(:page_number, result.page_number || 0)
     |> assign(:page_size, result.page_size || 0)
     |> assign(:total_entries, result.total_entries || 0)
     |> assign(:total_pages, result.total_pages || 0)}
  end


  def get_str(state) do
    Enum.zip(Utils.states, Utils.state_names ++ Utils.territories)
      |> Enum.find(fn {abbr,name} -> abbr == state end)
      |> Kernel.elem(1)
      |> Atom.to_string()
  end

  def api_query(state) do
    state_str = get_str(state)
    IO.inspect(state_str, label: "State")
    {:ok, resp} = 
      Finch.build(:get, "https://civicinfo.googleapis.com/civicinfo/v2/representatives?address=#{state_str}&key=#{System.fetch_env!("GCLOUD_API_KEY")}") 
      |> Finch.request(FanCan.Finch)

    {:ok, body} = Jason.decode(resp.body)

    IO.inspect(body["offices"], label: "Offices")
    IO.inspect(body["officials"], label: "Officials")

    %{"offices" => body["offices"], "officials" => body["officials"]}
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
    |> assign(:messages, [])
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
