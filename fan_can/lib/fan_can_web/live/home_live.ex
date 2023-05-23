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
    # for follow = %UserFollows{} <- socket.assigns.current_user_follows do
    #   IO.inspect(follow, label: "Type")
    #   # Subscribe to user_follows. E.g. forums that user subscribes to
    #   case follow.type do
    #     :candidate -> TopicHelpers.subscribe_to_followers("candidate", follow.follow_ids)
    #     :user -> TopicHelpers.subscribe_to_followers("user", follow.follow_ids)
    #     :forum -> TopicHelpers.subscribe_to_followers("forum", follow.follow_ids)
    #     :election -> TopicHelpers.subscribe_to_followers("election", follow.follow_ids)
    #   end
    # end

    # with %{post_ids: post_ids, thread_ids: thread_ids} <- socket.assigns.current_user_published_ids do
    #   IO.inspect(thread_ids, label: "thread_ids_b")
    #   for post_id <- post_ids do
    #     FanCanWeb.Endpoint.subscribe("posts_" <> post_id)
    #   end
    #   for thread_id <- thread_ids do
    #     FanCanWeb.Endpoint.subscribe("threads_" <> thread_id)
    #   end
    # end
    # FanCanWeb.Endpoint.subscribe("topic")
    IO.inspect(socket, label: "Socket")
    pid = spawn(FanCanWeb.SubscriptionServer, :start, [])
    IO.inspect(pid, label: "SubscriptionSupervisor PIN =>=>=>=>")
    send pid, {:subscribe_user_follows, socket.assigns.current_user_follows}
    send pid, {:subscribe_user_published, socket.assigns.current_user_published_ids}
    {:ok, 
     socket
     |> assign(:messages, [])}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.header class="text-center">
        Hello <%= assigns.current_user.username %> || Welcome to Fantasy Candidate
        <:subtitle>Not Really Sure What We're Doing Here Yet</:subtitle>
      </.header>

      <div class="mx-auto">
      
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
            <Heroicons.LiveView.icon name="chat-bubble-left-right" type="outline" class="h-10 w-10 text-black" />
            Forums
          </.link>
        </div>

      </div>
    </div>
    """
  end

  def handle_event("validate_email", params, socket) do
    %{"current_password" => password, "user" => user_params} = params

    email_form =
      socket.assigns.current_user
      |> Accounts.change_user_email(user_params)
      |> Map.put(:action, :validate)
      |> to_form()

    {:noreply, assign(socket, email_form: email_form, email_form_current_password: password)}
  end

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

  # def handle_event("new_message", params, socket) do
  #   {:noreply, socket}
  # end
end