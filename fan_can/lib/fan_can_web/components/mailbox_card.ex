defmodule FanCanWeb.Components.MailboxCard do
  use Phoenix.Component

  def display(assigns) do
    ~H"""
      <section class="text-white body-font">
        <button class="rounded-lg bg-zinc-100 px-2 py-1 text-black hover:bg-zinc-200/80" phx-click={FanCanWeb.CoreComponents.show_modal("user-modal")}><span aria-hidden="true">📧</span> Messages</button>
      </section>
    """
  end
end