defmodule FanCanWeb.HomeLive do
  use FanCanWeb, :live_view

  alias FanCan.Accounts

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
    FanCanWeb.Endpoint.subscribe("topic")
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <.header class="text-center">
      Hello <%= assigns.current_user.username %> || Welcome to Fantasy Candidate
      <:subtitle>Not Really Sure What We're Doing Here Yet</:subtitle>
    </.header>

          <div>
            <a
              href="/candidates"
              class="group -mx-2 -my-0.5 inline-flex items-center gap-3 rounded-lg px-2 py-0.5 hover:bg-zinc-50 hover:text-zinc-900"
            >
              <svg
                viewBox="0 0 16 16"
                aria-hidden="true"
                class="h-4 w-4 fill-zinc-400 group-hover:fill-zinc-600"
              >
                <path d="M8 13.833c3.866 0 7-2.873 7-6.416C15 3.873 11.866 1 8 1S1 3.873 1 7.417c0 1.081.292 2.1.808 2.995.606 1.05.806 2.399.086 3.375l-.208.283c-.285.386-.01.905.465.85.852-.098 2.048-.318 3.137-.81a3.717 3.717 0 0 1 1.91-.318c.263.027.53.041.802.041Z" />
              </svg>
              Candidates
            </a>
          </div>

          <div>
            <a
              href="/elections"
              class="group -mx-2 -my-0.5 inline-flex items-center gap-3 rounded-lg px-2 py-0.5 hover:bg-zinc-50 hover:text-zinc-900"
            >
              <svg
                viewBox="0 0 16 16"
                aria-hidden="true"
                class="h-4 w-4 fill-zinc-400 group-hover:fill-zinc-600"
              >
                <path d="M8 13.833c3.866 0 7-2.873 7-6.416C15 3.873 11.866 1 8 1S1 3.873 1 7.417c0 1.081.292 2.1.808 2.995.606 1.05.806 2.399.086 3.375l-.208.283c-.285.386-.01.905.465.85.852-.098 2.048-.318 3.137-.81a3.717 3.717 0 0 1 1.91-.318c.263.027.53.041.802.041Z" />
              </svg>
              Elections
            </a>
          </div>

          <div>
            <a
              href="/forums"
              class="group -mx-2 -my-0.5 inline-flex items-center gap-3 rounded-lg px-2 py-0.5 hover:bg-zinc-50 hover:text-zinc-900"
            >
              <svg
                viewBox="0 0 16 16"
                aria-hidden="true"
                class="h-4 w-4 fill-zinc-400 group-hover:fill-zinc-600"
              >
                <path d="M8 13.833c3.866 0 7-2.873 7-6.416C15 3.873 11.866 1 8 1S1 3.873 1 7.417c0 1.081.292 2.1.808 2.995.606 1.05.806 2.399.086 3.375l-.208.283c-.285.386-.01.905.465.85.852-.098 2.048-.318 3.137-.81a3.717 3.717 0 0 1 1.91-.318c.263.027.53.041.802.041Z" />
              </svg>
              Forums
            </a>
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
  @impl true
  def handle_info(%{event: "new_message", payload: new_message}, socket) do
    updated_messages = socket.assigns[:messages] ++ [new_message]
    IO.inspect(new_message, label: "New Message")
    {:noreply, socket |> assign(:messages, updated_messages)}
  end
end