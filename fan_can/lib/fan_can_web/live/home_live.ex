defmodule FanCanWeb.HomeLive do
  use FanCanWeb, :live_view

  alias FanCan.Accounts
  alias FanCan.Core.TopicHelpers
  alias FanCan.Accounts.UserFollows

#   def mount(%{"token" => token}, _session, socket) do
#     socket =
#       case Accounts.update_user_email(socket.assigns.current_user, token) do
#         :ok ->
#           put_flash(socket, :info, "Email changed successfully.")

#         :error ->
#           put_flash(socket, :error, "Email change link is invalid or it has expired.")
#       end

#     {:ok, push_navigate(socket, to: ~p"/users/settings")}
#   end

  def mount(_params, _session, socket) do
    IO.inspect(self(), label: "Self")
    IO.inspect(socket, label: "Home Socket")
    for follow = %UserFollows{} <- socket.assigns.current_user_follows do
      IO.inspect(follow, label: "Type")
      # Subscribe to user_follows. E.g. forums that user subscribes to
      sub_and_add(follow, socket)
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
    # # FanCanWeb.Endpoint.subscribe("topic")
    # IO.inspect(socket, label: "Socket")
    # pid = spawn(FanCanWeb.SubscriptionServer, :start, [])
    # IO.inspect(pid, label: "SubscriptionSupervisor PIN =>=>=>=>")
    # send pid, {:subscribe_user_follows, socket.assigns.current_user_follows}
    # send pid, {:subscribe_user_published, socket.assigns.current_user_published_ids}
    # # ThinWrapper.put("game_data", game_data)
    # # game_data = ThinWrapper.get("game_data")
    {:ok, 
     socket
     |> assign(:messages, [])}
  end

  defp sub_and_add(follow, socket) do
    case follow.type do
      :candidate -> TopicHelpers.subscribe_to_followers("candidate", follow.follow_ids)
      :user -> TopicHelpers.subscribe_to_followers("user", follow.follow_ids)
      :forum -> TopicHelpers.subscribe_to_followers("forum", follow.follow_ids)
      :election -> TopicHelpers.subscribe_to_followers("election", follow.follow_ids)
      :races -> TopicHelpers.subscribe_to_followers("races", follow.follow_ids)
    end
  end

  defp get_races(follows) do
    Enum.filter(follows, fn x -> x.type == :races end)
  end

  defp get_elections(follows) do
    Enum.filter(follows, fn x -> x.type == :election end)
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header class="text-center">
        Hello <%= assigns.current_user.username %> || Welcome to Fantasy Candidate
        <:subtitle>Not Really Sure What We're Doing Here Yet</:subtitle>
      </.header>

      <div class="mx-auto text-white">
      
        <div>
          <.link 
            href={~p"/candidates"}
            class="group -mx-2 -my-0.5 inline-flex items-center gap-3 rounded-lg px-2 py-0.5 hover:bg-zinc-50 hover:text-zinc-900"
          >
            <Heroicons.LiveView.icon name="users" type="outline" class="h-10 w-10 text-emerald" />
            Candidates
          </.link>
        </div>

        <div>
          <.link 
            href={~p"/elections"}
            class="group -mx-2 -my-0.5 inline-flex items-center gap-3 rounded-lg px-2 py-0.5 hover:bg-zinc-50 hover:text-zinc-900"
          >
            <Heroicons.LiveView.icon name="check-badge" type="outline" class="h-10 w-10 text-red" />
            Elections
          </.link>
        </div>

        <div>
          <.link 
            href={~p"/forums"}
            class="group -mx-2 -my-0.5 inline-flex items-center gap-3 rounded-lg px-2 py-0.5 hover:bg-zinc-50 hover:text-zinc-900"
          >
            <Heroicons.LiveView.icon name="chat-bubble-left-right" type="outline" class="h-10 w-10 text-white" />
            Forums
          </.link>
        </div>

      </div>

        <div class="grid justify-center md:grid-cols-3 lg:grid-cols-4 gap-3 lg:gap-4">
          <div class="text-center m-auto border-solid border-2 border-white rounded-lg p-2">
            <div class="text-white inline"><Heroicons.LiveView.icon name="eye" type="outline" class="inline h-5 w-5 text-white m-2" /> Races You Are Watching</div>
              <div class="text-white">
                <div :for={race <- get_races(@current_user_follows)} class="">
                  race.id
                </div>
              </div>
          </div>

          <div class="text-center m-auto border-solid border-2 border-white rounded-lg p-2">
            <div class="text-white inline"><Heroicons.LiveView.icon name="star" type="outline" class="inline h-5 w-5 text-white m-2" /> Your List of Favorites</div>
              <div class="text-white">
                 Map Over (Diff Icon for Each Type (Race, Ballot, Candidate etc)
              </div>
          </div>

          <div class="text-center m-auto border-solid border-2 border-white rounded-lg p-2">
            <div class="text-white inline"><Heroicons.LiveView.icon name="star" type="outline" class="inline h-5 w-5 text-white m-2" /> Your Shred Items</div>
              <div class="text-white">
                <div :for={election <- get_elections(@current_user_follows)} class="">
                  election.id
                </div>
              </div>
          </div>
        </div>
    </div>
    """
  end

  @impl true
  def handle_event("validate_email", params, socket) do
    %{"current_password" => password, "user" => user_params} = params

    email_form =
      socket.assigns.current_user
      |> Accounts.change_user_email(user_params)
      |> Map.put(:action, :validate)
      |> to_form()

    {:noreply, assign(socket, email_form: email_form, email_form_current_password: password)}
  end

  @impl true
  def handle_event("update_email", params, socket) do
    %{"current_password" => password, "user" => user_params} = params
    user = socket.assigns.current_user

    case Accounts.apply_user_email(user, password, user_params) do
      {:ok, applied_user} ->
        Accounts.deliver_user_update_email_instructions(
          applied_user,
          user.email,
          &url(~p"/users/settings/confirm_email/#{&1}")
        )

        info = "A link to confirm your email change has been sent to the new address."
        {:noreply, socket |> put_flash(:info, info) |> assign(email_form_current_password: nil)}

      {:error, changeset} ->
        {:noreply, assign(socket, :email_form, to_form(Map.put(changeset, :action, :insert)))}
    end
  end

  @impl true
  def handle_info(%{event: "new_message", payload: new_message}, socket) do
    updated_messages = socket.assigns[:messages] ++ [new_message]
    IO.inspect(new_message, label: "New Message")

    {:noreply, 
     socket 
     |> assign(:messages, updated_messages)
     |> put_flash(:info, "PubSub: #{new_message.string}")}
  end

  # def handle_event("new_message", params, socket) do
  #   {:noreply, socket}
  # end
end