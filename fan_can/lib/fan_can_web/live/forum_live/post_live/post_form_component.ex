defmodule FanCanWeb.ForumLive.PostLive.PostFormComponent do
  use FanCanWeb, :live_component

  alias FanCan.Site

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
      </.header>

      <.simple_form
        for={@form}
        id="post-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:content]} type="textarea" label="Content" />
        <:actions>
          <.button phx-disable-with="Saving...">Save post</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{post: post} = assigns, socket) do
    changeset = Site.change_post(post)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"post" => post_params}, socket) do
    changeset =
      socket.assigns.post
      |> Site.change_post(post_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"post" => post_params}, socket) do
    save_post(socket, socket.assigns.action, post_params)
  end

  defp save_post(socket, :edit, post_params) do
    case Site.update_post(socket.assigns.post, post_params) do
      {:ok, post} ->
        notify_parent({:saved, post})
        updated_message = %{type: :post, string: "post #{socket.assigns.post.title} has been edited by #{socket.assigns.user.username}"}
        FanCanWeb.Endpoint.broadcast!("post_" <> post.id, "new_message", updated_message)

        {:noreply,
         socket
         |> put_flash(:info, "post updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_post(socket, :new, post_params) do
    case Site.create_post(post_params) do
      {:ok, post} ->
        notify_parent({:saved, post})
        new_message = %{type: :post, string: "post #{socket.assigns.post.title} has just been added by #{socket.assigns.user.username}"}
        FanCanWeb.Endpoint.broadcast!("post_" <> post.id, "new_message", new_message)

        {:noreply,
         socket
         |> put_flash(:info, "post created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
