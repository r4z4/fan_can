defmodule FanCanWeb.CandidateLive.FormComponent do
  use FanCanWeb, :live_component

  alias FanCan.Public

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage candidate records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="candidate-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:prefix]} type="text" label="Prefix" />
        <.input field={@form[:f_name]} type="text" label="F name" />
        <.input field={@form[:l_name]} type="text" label="L name" />
        <.input field={@form[:suffix]} type="text" label="Suffix" />
        <.input field={@form[:state]} type="text" label="State" />
        <.input field={@form[:district]} type="number" label="District" />
        <.input field={@form[:residence]} type="text" label="Residence" />
        <.input field={@form[:type]} type="text" label="Type" />
        <.input
          field={@form[:party]}
          type="select"
          label="Party"
          prompt="Choose a value"
          options={Ecto.Enum.values(FanCan.Public.Candidate, :party)}
        />
        <.input field={@form[:cpvi]} type="text" label="Cpvi" />
        <.input field={@form[:incumbent_since]} type="date" label="Incumbent since" />
        <.input field={@form[:dob]} type="date" label="Dob" />
        <.input
          field={@form[:attachments]}
          type="select"
          multiple
          label="Attachments"
          options={[]}
        />
        <:actions>
          <.button phx-disable-with="Saving...">Save Candidate</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{candidate: candidate} = assigns, socket) do
    changeset = Public.change_candidate(candidate)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"candidate" => candidate_params}, socket) do
    changeset =
      socket.assigns.candidate
      |> Public.change_candidate(candidate_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"candidate" => candidate_params}, socket) do
    save_candidate(socket, socket.assigns.action, candidate_params)
  end

  defp save_candidate(socket, :edit, candidate_params) do
    case Public.update_candidate(socket.assigns.candidate, candidate_params) do
      {:ok, candidate} ->
        notify_parent({:saved, candidate})

        {:noreply,
         socket
         |> put_flash(:info, "Candidate updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_candidate(socket, :new, candidate_params) do
    case Public.create_candidate(candidate_params) do
      {:ok, candidate} ->
        notify_parent({:saved, candidate})

        {:noreply,
         socket
         |> put_flash(:info, "Candidate created successfully")
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
